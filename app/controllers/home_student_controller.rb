#
class HomeStudentController < ApplicationController
  # TODO: run this through the DRYer.
  def show
    if current_user
      @user = current_user
      @assessments = Assessment.where(section_id: @user.sections[0])
      @posts = Post.where(user_id: @user.id)
    end
  end

  def show_id
    @user = User.find params[:id]
    @assessments = Assessment.where(section_id: @user.sections[0])
    @posts = Post.where(user_id: @user.id)
    render :show
  end
end
