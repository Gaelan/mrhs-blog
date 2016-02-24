class CoursePolicy < ApplicationPolicy
  alias course record

  class Scope < Scope
    def resolve
      scope
    end
  end

  def allowed?
    user.admin? || user.teacher?
  end

  def create?
    allowed?
  end

  def update?
    allowed?
  end

  def destroy?
    allowed?
  end

  def index?
    true
  end
end
