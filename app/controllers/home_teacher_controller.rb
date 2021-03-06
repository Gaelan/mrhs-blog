# app/controllers/home_teacher_controller.rb - Teacher home page.
#
class HomeTeacherController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize Course
    authorize Section
    authorize User

    @courses  = policy_scope Course.all
    @sections = policy_scope Section.all
    @users = policy_scope User.all

    @periods = @sections.map do |s|
      {
        session: s.session,
        period:  s.period,
        courses: get_courses(s.session, s.period)
      }
    end.uniq
  end

  private

  def get_courses(session, period)
    @sections.select do |section|
      section.session == session && section.period == period
    end.map do |c|
      {
        course: c.course_id,
        title: Course.find(c.course_id).title,
        section: c.id,
        students: get_students(c),
        assessments: get_assessments(c.id)
      }
    end
  end

  def get_students(section)
    section.students.sort do |l, r|
      unless l[:family_name] == r[:family_name]
        l[:family_name] <=> r[:family_name]
      else
        l[:given_name] <=> r[:given_name]
      end
    end
  end

  def get_assessments(section)
    Assessment
      .where(section_id: section)
      .order(due_date: :desc)
      .map &:id
  end
end
