class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def allowed?
    user.admin? || user.teacher?
  end

  def become?
    allowed? || Rails.env.development? || Rails.env.test?
  end

  def index?
    true
  end

  def update?
    allowed?
  end
end
