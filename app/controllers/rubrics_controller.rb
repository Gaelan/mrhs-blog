class RubricsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rubric, only: [:show, :edit, :update, :destroy]

  after_action :verify_authorized

  # GET /rubrics
  # GET /rubrics.json
  def index
    authorize Rubric
    @rubrics = if params[:task_id]
                 # Find the objectives for the task, and then select the rubric
                 # entries that are the best fit.
                 Rubric.where(task_id: params[:task_id])
               else
                 Rubric.all
    end.order(strand_id: :asc, band: :asc, level: :asc)
    @rubrics_grid = initialize_grid @rubrics
  end

  # GET /rubrics/1
  # GET /rubrics/1.json
  def show
    @rubric = Rubric.find(params[:id])
    authorize @rubric
  end

  # GET /rubrics/new
  def new
    @rubric = Rubric.new
    authorize @rubric
    store_location

    # XXX - need to set contexts for a Unit or Project rubric as well, others?
    if params[:task_id]
      # Creating a new rubric for a Task.
      @rubric.level = :task
      @rubric.rubricable = Task.find(params[:task_id])
      # Use the Stands set by the Task.
      @strands = Task.find(params[:task_id]).strands
    end
    if params[:base_rubric_id]
      # Creating a new rubric based on a, presumably, "higher" level one.
      # We could be coming here after setting some defaults based on where the
      # user clicked the 'new' link, so check that values aren't already set.
      @base_rubric = Rubric.find(params[:base_rubric_id])
      @rubric.level || @rubric.level = @base_rubric.level.to_i + 1
      @rubric.strand = @base_rubric.strand
      @rubric.band = @base_rubric.band
      @rubric.criterion = @base_rubric.criterion
    end
  end

  # GET /rubrics/1/edit
  def edit
    authorize @rubric
    store_location
  end

  # POST /rubrics
  # POST /rubrics.json
  def create
    @rubric = Rubric.new(rubric_params)
    authorize @rubric
    @rubric.verify_level

    respond_to do |format|
      if @rubric.save
        format.html { redirect_back_or_default notice: 'Rubric was successfully created.' }
        format.json { render :show, status: :created, location: @rubric }
      else
        format.html { render :new }
        format.json { render json: @rubric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rubrics/1
  # PATCH/PUT /rubrics/1.json
  def update
    authorize @rubric
    # XXX - call rubric_params?
    if params[:rubric][:rubricable]
      params[:rubric][:rubricable_id] = params[:rubric][:rubricable]
      params[:rubric][:rubricable_type] = Task.name
    end
    @rubric.verify_level
    respond_to do |format|
      if @rubric.update(rubric_params)
        format.html { redirect_back_or_default notice: 'Rubric was successfully updated.' }
        format.json { render :show, status: :ok, location: @rubric }
      else
        format.html { render :edit }
        format.json { render json: @rubric.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rubrics/1
  # DELETE /rubrics/1.json
  def destroy
    authorize @rubric
    @rubric.destroy
    respond_to do |format|
      format.html { redirect_to rubrics_url, notice: 'Rubric was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_rubric
    @rubric = Rubric.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rubric_params
    params.require(:rubric).permit(:level, :band, :criterion, :strand_id,
                                   :rubricable_id, :rubricable_type, :base_rubric_id)
  end
end
