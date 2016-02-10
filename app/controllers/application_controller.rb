class ApplicationController < ActionController::Base
  include Pundit
  before_action :update_active_time

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def new_session_path(scope)
    new_user_session_path
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(
        if request.referrer
          request.referrer != request.url ? request.referer : root_path
        else
          root_path
        end
    )
  end

  def update_active_time
    if current_user
      current_user.last_active_time = Time.current
      current_user.save
    end
  end
end
