#
class AssessmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_assessment,
                only: [:show, :edit, :update, :destroy, :score]

  after_action :verify_authorized

  # GET /assessments
  # GET /assessments.json
  def index
    authorize Assessment
    @assessments = Assessment.all.order(section_id: :asc, due_date: :asc)
    @assessments_grid = initialize_grid @assessments
  end

  # GET /assessments/1
  # GET /assessments/1.json
  def show
    # @assessment = Assessment.find(params[:id])
    # TODO: generate pundit policy for Unit (and check for others)
    # authorize @unit
    # @tasks_grid = initialize_grid @unit.tasks
    authorize @assessment
  end

  # GET /assessments/new
  def new
    @assessment = Assessment.new
    authorize @assessment

    # TODO: make externally configurable.
    @assessment.value = 8
  end

  # GET /assessments/1/edit
  def edit
    store_location
    authorize @assessment
  end

  # POST /assessments
  # POST /assessments.json
  def create
    @assessment = Assessment.new(assessment_params)
    authorize @assessment

    # TODO: figure out why we're getting a null 0th element in task_ids
    if @assessment.title == ''
      # TODO: think about what to do if the Task title changes.
      @assessment.title = Task.find(params[:assessment][:task_ids][1]).title
    end

    respond_to do |format|
      if @assessment.save
        format.html do
          redirect_back_or_default(notice: 'Assessment was successfully created.')
        end
        format.json { render :show, status: :created, location: @assessment }
      else
        format.html { render :new }
        format.json do
          render json: @assessment.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /assessments/1
  # PATCH/PUT /assessments/1.json
  def update
    authorize @assessment
    respond_to do |format|
      if @assessment.update(assessment_params)
        format.html do
          redirect_back_or_default(notice: 'Assessment was successfully updated.')
        end
        format.json { render :show, status: :ok, location: @assessment }
      else
        format.html { render :edit }
        format.json do
          render json: @assessment.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /assessments/1
  # DELETE /assessments/1.json
  def destroy
    authorize @assessment
    # TODO: also authorize assessment_task?
    # XXX - There may work posted against the assessment we are deleting?
    #       What should be done then? Block deletion, or prompt to replace with
    #       another assessment. At the very least we need to clean up any
    #       references to deleted assessments.

    # Find and destroy AssessmentTask instances first.
    AssessmentTask.where(assessment_id: @assessment.id).each(&:destroy)
    @assessment.destroy
    respond_to do |format|
      format.html do
        redirect_to assessments_url,
                    notice: 'Assessment was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  # GET /assessments/:id/score
  # GET /assessments/:id/score.json
  #
  # Retrieve a set of Posts to score.
  #
  def score
    authorize @assessment
    # XXX - what else needs to be authorized? Enrollment?

    if @assessment.due_date > Time.current
      # Due date is still in the future, only score published posts.
      @posts = Post.where(assessment: @assessment, published: true)
      @missing = nil
    else
      # Due date has passed, set up to score everything.
      @posts = Post.where(assessment: @assessment)
      @missing = @assessment.section
                            .students.order(family_name: :asc, given_name: :asc)
    end

    @posts.includes!(:user)
          .order!('users.family_name ASC, users.given_name ASC')
    strands = @assessment.strands.count

    @posts = @posts.select do |p|
      @missing.empty? || @missing -= [User.find(p.user_id)]

      p.scores.count != strands
    end

    unless @missing.empty?
      # Remove users with missing posts that have already been scored.
      scores = Score.where(user: @missing, assessment: @assessment)
      @missing.select! do |u|
        scores.where(user: u).count != strands
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = params[:user_id] ? User.find(params[:user_id]) : current_user
  end

  def set_assessment
    @assessment = Assessment.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def assessment_params
    params.require(:assessment)
          .permit(:assigned_date, :due_date, :value, :weight, :autoscore,
                  :title, :category, :section_id, task_ids: []
                 )
  end
end
