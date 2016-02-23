#
class HomeStudentController < ApplicationController
  def show
    @user = current_user
    @assessments = Assessment.where(section_id: @user.sections[0])
    @posts = Post.where(user_id: @user.id)
  end

  def show_id
    @user = User.find params[:id]
    @assessments = Assessment.where(section_id: @user.sections[0])
    @posts = Post.where(user_id: @user.id)
    render :show
  end
end
