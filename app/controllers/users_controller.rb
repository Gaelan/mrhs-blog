#
class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action  :verify_authorized

  def index
    authorize User
    users = if params[:section_id]
              Section.find(params[:section_id]).students
            else
              User.all
            end
    @users = policy_scope users.order(created_at: :asc)
    @users_grid = initialize_grid @users
  end

  def edit
    session[:return_to] ||= request.referer
    @user = User.find params[:id]
    authorize @user
  end

  def update
    @user = User.find params[:id]
    authorize @user
    @user.update user_params

    redirect_to session.delete(:return_to) || root_path
  end

  #binding.pry

  # if Rails.env.development? || current_user.teacher? || current_user.admin?
    # XXX security checks commented out!!!
    def become
      skip_authorization
      sign_in_and_redirect User.find(params[:user][:id])
    end
  # end

  private

  def user_params
    params.require(:user).permit(section_ids: [])
  end
end
