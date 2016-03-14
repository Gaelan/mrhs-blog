class ScoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_score, only: [:show, :edit, :update, :destroy]

  after_action :verify_authorized

  # GET /scores
  # GET /scores.json
  def index
    authorize Score
    @scores = Score.all
  end

  # GET /scores/1
  # GET /scores/1.json
  def show
    authorize @score
  end

  # GET /scores/new
  def new
    @score = Score.new
    authorize @score
  end

  # GET /scores/1/edit
  def edit
    authorize @score
  end

  # POST /scores
  # POST /scores.json
  def create
    @score = Score.new(score_params)
    authorize @score

    respond_to do |format|
      if @score.save
        format.html { redirect_to :back, notice: 'Score was successfully created.' }
        format.json { render :show, status: :created, location: @score }
        format.js { render :update_rubric }
      else
        format.html { render :new }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scores/1
  # PATCH/PUT /scores/1.json
  def update
    authorize @score

    respond_to do |format|
      if @score.update(score_params)
        format.html { redirect_to :back, notice: 'Score was successfully updated.' }
        format.json { render :show, status: :ok, location: @score }
        format.js { render :update_rubric }
      else
        format.html { render :edit }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1
  # DELETE /scores/1.json
  def destroy
    authorize @score
    @score.destroy
    respond_to do |format|
      format.html { redirect_to scores_url, notice: 'Score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Post scores for missing assignments.
  #
  # TODO: what is the right way to do this? Seems like scores should be posted
  #       through the Score controller...
  def bulk
    authorize Score

    scores = params[:missing].map do |uid|
      Assessment.find(params[:id]).strands.map do |s|
        {
          score: 0,
          drop: false,
          user_id: uid,
          assessment_id: params[:id],
          strand_id: s.id,
          note: 'Assignment not done.'
        }
      end
    end

    scores.map do |assessment|
      assessment.map do |strand|
        Score.create strand
      end
    end

    redirect_to :back # Should take us back to the Assessment scoring page.
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_score
    @score = Score.find(params[:id])
  end

  # TODO: do we need set_user?
  def set_user
    @user = params[:user_id] ? User.find(params[:user_id]) : current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def score_params
    params.require(:score).permit(:score, :drop, :note, :user_id, :assessment_id, :strand_id)
  end
end
