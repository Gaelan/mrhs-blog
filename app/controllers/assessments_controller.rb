#
class AssessmentsController < ApplicationController
  before_action :set_assessment,
                only: [:show, :edit, :update, :destroy]

  # GET /assessments
  # GET /assessments.json
  def index
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
  end

  # GET /assessments/new
  def new
    @assessment = Assessment.new
    # TODO: make externally configurable.
    @assessment.value = 8
  end

  # GET /assessments/1/edit
  def edit
  end

  # POST /assessments
  # POST /assessments.json
  def create
    @assessment = Assessment.new(assessment_params)

    # TODO: figure out why we're getting a null 0th element in task_ids
    if @assessment.title == ''
      # TODO: think about what to do if the Task title changes.
      @assessment.title = Task.find(params[:assessment][:task_ids][1]).title
    end

    respond_to do |format|
      if @assessment.save
        format.html do
          redirect_to @assessment,
                      notice: 'Assessment was successfully created.'
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
    respond_to do |format|
      if @assessment.update(assessment_params)
        format.html do
          redirect_to @assessment,
                      notice: 'Assessment was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @assessment }
      else
        format.html { render :edit }
        format.json do
          render json: @assessment.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /assessments/1
  # DELETE /assessments/1.json
  def destroy
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

  private

  # Use callbacks to share common setup or constraints between actions.
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
