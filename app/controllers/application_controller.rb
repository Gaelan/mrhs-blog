#
class ApplicationController < ActionController::Base
  include Pundit
  before_action :update_active_time

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def new_session_path(_scope)
    new_user_session_path
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
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

  def load_attributes_from_request(object)
    # permitted_attributes comes from Pundit.
    object.attributes = permitted_attributes object
  end

  # Functions for managing redirection on edits.
  def store_location
    session[:return_to] = request.referrer
  end

  def redirect_back_or_default(default = root_path, notice: '')
    # TODO: think about a better name
    # TODO: figure out why notice doesn't appear some times (on new objective, works on edit)
    redirect_to (session.delete(:return_to) || default), notice: notice
  end
end
