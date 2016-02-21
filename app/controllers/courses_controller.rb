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
  end

  # GET /courses/new
  def new
    @course = Course.new
    authorize @course
  end

  #
  def edit
    @course = Course.find(params[:id])
    authorize @course
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    authorize @course

    if @course.save
      redirect_to @course
    else
      render 'new'
    end
  end

  # POST /courses/edit
  def update
    @course = Course.find(params[:id])
    authorize @course

    if @course.update(course_params)
      redirect_to @course
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
        sections_attributes: [:id, :session, :period, :year, :name, :_destory])
    end
end
