#
class UsersController < ApplicationController
  before_action :authenticate_user!, except: :become # policy checks for admin
  after_action  :verify_authorized

  def index
    authorize User
    users = if params[:section_id]
              Section.find(params[:section_id]).students
            else
              User.all
            end
    @users = policy_scope users.order(name: :asc)
    @users_grid = initialize_grid @users
  end

  def edit
    store_location
    @user = User.find params[:id]
    authorize @user
  end

  def update
    @user = User.find params[:id]
    authorize @user
    @user.update user_params

    redirect_back_or_default
  end

  def become
    authorize User
    # logger.debug 'hi'
    sign_in_and_redirect User.find(params[:user][:id])
  end

  private

  def user_params
    params.require(:user).permit(section_ids: [])
  end
end
