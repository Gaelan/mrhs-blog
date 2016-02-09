class PostPolicy < ApplicationPolicy
  alias_method :post, :record

  class Scope < Scope
    def resolve
      # The line below defines what posts `user` is allowed to see.  You can use
      # the booleans `user.admin?`, `user.mentor?`, `user.student?` etc.
      scope.where(published: true).or(scope.where(user: user))
    end
  end

  def is_owner?
    post.user == user
  end

  # The below methods define what actions `user` can perform. Most should be
  # self-explanatory. `index` is access to the list of posts. In all but index,
  # you can access the relevant post in `post`.
  def create?
    is_owner?
  end

  def update?
    is_owner?
  end

  def destroy?
    is_owner?
  end

  def index?
    true
  end
end
