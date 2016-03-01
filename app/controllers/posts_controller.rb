#
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /users/1/posts
  # GET /users/1/posts.json
  def user_index
    authorize Post
    # @posts = policy_scope @user.posts
    # posts = policy_scope @user.posts
    @posts = policy_scope @user.posts.order(created_at: :desc)
    @posts_grid = initialize_grid @posts
  end

  # GET /posts
  # GET /users/1/posts
  # GET /users/1/posts.json
  def index
    authorize Post
    if params[:user_id] || request.path == '/'
      @all_posts = false
      unless params[:user_id]
        # Missing when route is '/'
        params[:user_id] = @user.id
      end
      @posts = policy_scope @user.posts.order(created_at: :desc)
    else
      @all_posts = true
      @posts = policy_scope Post.all.order(created_at: :desc)
    end
    @posts_grid = initialize_grid @posts
  end

  # GET /users/1/posts/1
  # GET /users/1/posts/1.json
  def show
    authorize @post
  end

  # GET /users/1/posts/new
  def new
    @post = @user.posts.build
    authorize @post
    if (params[:task_id])
      # Coming here from a 'Get Started' link, so we know which prompt
      # the student wants to work on.
      @post.assessment_id = params[:task_id]
      binding.pry
    end
  end

  # GET /users/1/posts/1/edit
  def edit
    authorize @post
  end

  # POST /users/1/posts
  # POST /users/1/posts.json
  def create
    @post = @user.posts.create(post_params)
    authorize @post

    respond_to do |format|
      if @post.save
        format.html do
          redirect_to [@user, @post],
                      notice: 'Post was successfully created.'
        end
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1/posts/1
  # PATCH/PUT /users/1/posts/1.json
  def update
    authorize @post
    respond_to do |format|
      if @post.update(post_params)
        format.html do
          redirect_to [@user, @post],
                      notice: 'Post was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1/posts/1
  # DELETE /users/1/posts/1.json
  def destroy
    authorize @post
    @post.destroy
    respond_to do |format|
      format.html do
        redirect_to [@user, :posts],
                    notice: 'Post was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = params[:user_id] ? User.find(params[:user_id]) : current_user
  end

  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary Internet,
  # only allow the white list through.
  def post_params
    params.require(:post).permit(:published, :title, :body, :assessment_id,
                                 images_attributes: [:id, :file, :caption, :maker, :src, :_destroy])
  end
end
