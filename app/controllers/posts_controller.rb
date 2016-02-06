class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /users/1/posts
  # GET /users/1/posts.json
  def index
    authorize Post
    @posts = policy_scope @user.posts
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

    @post.level = @post.parent ? @post.parent.level + 1 : 1

    respond_to do |format|
      if @post.save
        format.html { redirect_to [@user, @post], notice: 'Post was successfully created.' }
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
        format.html { redirect_to [@user, @post], notice: 'Post was successfully updated.' }
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
      format.html { redirect_to [@user, :posts], notice: 'Post was successfully destroyed.' }
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:published, :title, :body, images_attributes: [:id, :file, :caption, :maker, :src, :_destroy])
  end
end
