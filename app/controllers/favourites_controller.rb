class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.favourite_posts
  end

  def create
    post = Post.find params[:post_id]
    fav = Favourite.new(post: post, user: current_user)
    if fav.save
      redirect_to post_path(post)
    else
      redirect_to post_path(post), alert: "Unable to favourite."
    end
  end

  def destroy
    fav = Favourite.find params[:id]
    post = Post.find params[:post_id]
    fav.destroy if can? :destroy, Favourite
    redirect_to post_path(post)
  end

end
