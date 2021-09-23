class PostsController < ApplicationController
  def index
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @post = Post.new
  end

  def create
    trip = Trip.find(params[:trip_id])
    trip.posts.build(post_params)
    if trip.valid?
      trip.save
      redirect_to trip_path(trip)
    else
      flash[:messages] = trip.errors.full_messages
      redirect_to new_trip_post_path(trip)
    end
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
    if post.update(post_params)
      redirect_to trip_post_path(post.trip,post)
    else
      flash[:messages] = post.errors.full_messages
      redirect_to edit_trip_post_path(post.trip)
    end
  end

  def destroy
    post = Post.find(params[:id])
    trip = post.trip
    post.destroy
    redirect_to trip_path(trip)
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end
end
