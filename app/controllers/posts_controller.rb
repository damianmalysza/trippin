class PostsController < ApplicationController
  def index
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @post = Post.new
  end

  def create
    trip = Trip.find(params[:trip_id])
    post = Post.create(post_params)
    post.user = current_user
    trip.posts << post
    redirect_to trip_path(trip)
  end

  def show
    @trip = Trip.find(params[:trip_id])
    @post = Post.find(params[:id])
  end

  def edit
    @trip = Trip.find(params[:trip_id])
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to trip_post_path(post.trip,post)
  end

  def destroy
    post = Post.find(params[:id])
    trip = post.trip
    post.destroy
    redirect_to trip_path(trip)
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
