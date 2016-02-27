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
    #
    # binding.pry

    @tasks = policy_scope Task.all
    @tasks_grid = initialize_grid @tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    # binding.pry
    @task = Task.find(params[:id])
    authorize @task
    @strands = @task.strands.order(objective_id: :asc) # TODO: hack, should be objective.group
    binding.pry
    @strands_grid = initialize_grid @strands
    @rubrics = Rubric.where(task_id: params[:id])
    # binding.pry
    @rubrics_grid = initialize_grid @rubrics
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
