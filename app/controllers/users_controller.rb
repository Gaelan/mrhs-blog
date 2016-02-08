class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action  :verify_authorized

  def index
    authorize User
    @users = policy_scope User.all.order(section_id: :asc, name: :asc)
    @users_grid = initialize_grid @users
  end
end
