class CoursePolicy < ApplicationPolicy
  alias_method :course, :record

  class Scope < Scope
    def resolve
      scope
    end
  end

  def is_allowed?
    true
  end

  def create?
    is_allowed?
  end

  def update?
    is_allowed?
  end

  def destroy?
    is_allowed?
  end

  def index?
    true
  end
end
