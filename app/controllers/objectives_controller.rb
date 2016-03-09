# app/controllers/objectives_controller.rb
#
# TODO: use Pundit
#
class ObjectivesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_objective, only: [:show, :edit, :update, :destroy]

  after_action :verify_authorized

  # GET /objectives
  # GET /objectives.json
  def index
    authorize Objective
    @objectives = Objective.all.order(group: :asc)
    @objectives_grid = initialize_grid @objectives, per_page: 32
  end

  # GET /objectives/1
  # GET /objectives/1.json
  def show
    authorize @objective
  end

  # GET /objectives/new
  def new
    @objective = Objective.new
    authorize @objective
  end

  # GET /objectives/1/edit
  def edit
    store_location
    authorize @objective
  end

  # POST /objectives
  # POST /objectives.json
  def create
    @objective = Objective.new(objective_params)
    authorize @objective

    respond_to do |format|
      if @objective.save
        format.html { redirect_back_or_default(notice: 'Objective was successfully created.') }
        format.json { render :show, status: :created, location: @objective }
      else
        format.html { render :new }
        format.json { render json: @objective.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /objectives/1
  # PATCH/PUT /objectives/1.json
  def update
    authorize @objective
    respond_to do |format|
      if @objective.update(objective_params)
        format.html { redirect_back_or_default(notice: 'Objective was successfully updated.') }
        format.json { render :show, status: :ok, location: @objective }
      else
        format.html { render :edit }
        format.json { render json: @objective.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /objectives/1
  # DELETE /objectives/1.json
  def destroy
    authorize @objective
    @objective.destroy
    respond_to do |format|
      format.html do
        redirect_to objectives_url,
                    notice: 'Objective was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_objective
    @objective = Objective.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def objective_params
    params.require(:objective).permit(:group, :name, :description,
                                      strands_attributes: [:number, :label, :description,
                                                           :id, :_destroy])
  end
end
