# app/controllers/home_teacher_controller.rb - Teacher home page.
#
class HomeTeacherController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize Course
    authorize Section
    authorize User

    @courses = policy_scope Course.all
    @sections = policy_scope Section.all
    @students = policy_scope User.all

    @periods = @sections.map do |s|
      {
        session: s.session,
        period: s.period,
        courses: get_courses(s.session, s.period)
      }
    end.uniq
    # binding.pry
  end

  private

  def get_courses(session, period)
    # binding.pry
    @sections.select do |section|
      section.session == session && section.period == period
    end.map do |c|
      {
        course: c.course_id,
        title: Course.find(c.course_id).title,
        section: c.id,
        students: get_students(c.id),
        assessments: get_assessments(c.id)
      }
    end
  end

  def get_students(section)
    Enrollment.where(section_id: section).map do |s|
      {
        id: s.student_id,
        name: @students.where(id: s.student_id)[0].name
      }
    end.sort { |l, r| l[:name] <=> r[:name] }
  end

  def get_assessments(section)
    Assessment
      .where(section_id: section)
      .order(due_date: :desc)
      .map &:id
  end
end
