class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action  :verify_authorized

  def index
    authorize User
    @users = policy_scope User.all.order(name: :asc)
  end

  def edit
    @user = User.find params[:id]
    authorize @user
  end

  def update
    @user = User.find params[:id]
    authorize @user
    @user.update user_params

    redirect_to [@user, :posts]
  end

  private

  def user_params
    params.require(:user).permit(section_ids: [])
  end
end
