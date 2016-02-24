#
class AssessmentsController < ApplicationController
  before_action :set_assessment, only: [:show, :edit, :update, :destroy]

  # GET /assessments
  # GET /assessments.json
  def index
    @assessments = Assessment.all
    @assessments_grid = initialize_grid @assessments
  end

  # GET /assessments/1
  # GET /assessments/1.json
  def show
  end

  # GET /assessments/new
  def new
    @assessment = Assessment.new
  end

  # GET /assessments/1/edit
  def edit
  end

  # POST /assessments
  # POST /assessments.json
  def create
    @assessment = Assessment.new(assessment_params)

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
                  :title, :category, :section_id,
                  tasks_attributes: [:id, :title, :category])
  end
end
