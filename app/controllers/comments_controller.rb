class CommentsController < ApplicationController
  after_action :verify_authorized
  def create
    comment = Comment.new
    comment.user = current_user
    load_attributes_from_request comment
    authorize comment
    comment.save!
    flash[:success] = "Your comment was saved!"
    redirect_back fallback_location: '/'
  end

  def update
  end
end
