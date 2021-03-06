#
class CoursesController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  # GET /courses
  def index
    authorize Course
    @courses = policy_scope Course.all
    @courses_grid = initialize_grid @courses
  end

  def show
    @course = Course.find(params[:id])
    authorize @course
    @sections_grid = initialize_grid @course.sections
    @units_grid = initialize_grid @course.units
  end

  # GET /courses/new
  def new
    @course = Course.new
    authorize @course
  end

  #
  def edit
    store_location
    @course = Course.find(params[:id])
    authorize @course
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    authorize @course

    if @course.save
      redirect_back_or_default
    else
      render 'new'
    end
  end

  # POST /courses/edit
  def update
    @course = Course.find(params[:id])
    authorize @course

    if @course.update(course_params)
      redirect_back_or_default
    else
      render 'edit'
    end
  end

  def destroy
    @course = Course.find(params[:id])
    authorize @course
    @course.destroy

    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit(:title, :short_title,
                                   objective_ids: [],
                                   sections_attributes: [:id, :session, :period, :year, :name, :_destory],
                                   unit_ids: [])
  end
end
