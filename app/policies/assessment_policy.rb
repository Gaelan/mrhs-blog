#
class AssessmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def allowed?
    user.teacher? || user.admin?
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
