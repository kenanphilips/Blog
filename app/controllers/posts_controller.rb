class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_owner, only: [:edit, :destroy, :update]

  # defining the 'new' method for posts
  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post), notice: "Post created successfully!"
    else
      flash[:alert] = "Post creation unsuccessful."
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def index
    @posts = Post.search(params[:search]).order('created_at DESC')
    if @posts.class == Array
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
    else
      @posts = @posts.page(params[:page]).per(10)
    end
  end

  def edit
    redirect_to root_path, alert: "Access denied." unless can? :edit, @post
  end

  def update
    redirect_to root_path, alert: "Access denied." unless can? :update, @post
    if @post.update post_params
      redirect_to post_path(@post), notice: "Post updated!"
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path, alert: "Access denied." unless can? :manage, @post
    @post.destroy
    redirect_to posts_path(@posts)
    flash[:notice] = "Post deleted!"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id, {tag_ids: []})
  end

  def find_post
    @post = Post.find params[:id]
  end

  def authenticate_user!
    redirect_to new_session_path, alert: "Please sign in." unless user_signed_in?
  end

  def authorize_owner
    redirect_to root_path, alert: "Access denied." unless can? :manage, @post
  end

end
