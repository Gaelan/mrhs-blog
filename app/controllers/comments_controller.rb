class CommentsController < ApplicationController
  after_action :verify_authorized
  def create
    comment = Comment.new comment_params
    comment.user = current_user
    authorize comment
    comment.save!
    flash[:success] = "Your comment was saved!"
    redirect_back fallback_location: '/'
  end

  def update
  end

  private

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end
end
