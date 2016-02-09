class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action  :verify_authorized

  def index
    authorize User
    @users = policy_scope User.all.order(created_at: :asc)
    @users_grid = initialize_grid @users
  end

  def edit
    @user = User.find params[:id]
    authorize @user
  end

  def update
    @user = User.find params[:id]
    authorize @user
    @user.update user_params

    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(section_ids: [])
  end
end
