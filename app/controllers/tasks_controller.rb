#
class TasksController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    authorize Task
    # TODO: should be showing students prompts through assessments...
    # TODO: change route, go through assessments?
    # enrollment = Enrollment.where(student_id: current_user.id)[0]
    # if enrollment then section = enrollment.section_id
    #   assessments = Assessment.where(section_id: section)
    # end

    @tasks = policy_scope Task.all
    @tasks_grid = initialize_grid @tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
    authorize @task
    @strands = @task.strands
                    .order(objective_id: :asc) # XXX: hack, should be objective.group
    strand_ids = @strands.map &:id
    @strands_grid = initialize_grid @strands
    strand_ids = @strands.map do |s|
      s.id
    end
    # Find applicable Rubrics
    @rubrics = []
    rubric_candidates = Rubric.where(strand_id: strand_ids)
    strand_ids.each do |sid|
      strand_rubrics = rubric_candidates.select { |r| r.strand_id == sid }
      bands = strand_rubrics.map &:band
      bands.each do |band|
        band_max = strand_rubrics.select { |r| r.band == band }.max_by &:level
        @rubrics += [band_max]
      end
    end
    # TODO: figure out why this hack is necessary
    @rubrics_hack = Rubric.where(id: (@rubrics.map &:id))
                          .order(
                             strand_id: :asc, # XXX - Hack, should be...
                             # strand.objective.group: :asc,
                             # strand.number: :asc,
                             band: :asc)
    @rubrics_grid = initialize_grid @rubrics_hack
    binding.pry
  end

  # GET /tasks/new
  def new
    @task = Task.new
    authorize @task
  end

  # GET /tasks/1/edit
  def edit
    authorize @task
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    authorize @task

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    authorize @task
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    authorize @task
    @task.destroy
    # XXX - Leaves orphan assessments, which breaks the assessment view.
    # TODO: Decide policy on removing tasks. Delete associated assessments?
    #       What about work posted against those assessments. We could just mark
    #       the task as "deleted."
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:title, :body, :category, :time_required,
                                 strand_ids: [])
  end
end
