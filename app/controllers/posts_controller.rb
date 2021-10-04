class PostsController < ApplicationController

  before_action :validate_post_owner, only: [:edit,:update] #only post owners should be able to modify their posts
  before_action :validate_post_owner_and_trip_owner, only: [:destroy] #trip owners should be able to delete posts
  before_action :validate_part_of_trip, only: [:new, :create]

  def new
    @trip = Trip.find(params[:trip_id])
    @post = Post.new
  end

  def create
    @trip = Trip.find(params[:trip_id])
    @post = @trip.posts.build(post_params)
    if @post.valid?
      @post.save
      redirect_to trip_path(@trip)
    else
      render :new
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
    @post = Post.find(params[:id])
    @trip = @post.trip
    if @post.update(post_params)
      redirect_to trip_post_path(@post.trip,@post)
    else
      render :edit
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

  def validate_post_owner
    post = Post.find(params[:id])
    redirect_to user_path(current_user) if current_user != post.user
  end

  def validate_post_owner_and_trip_owner
    post = Post.find(params[:id])
    redirect_to user_path(current_user) if current_user != post.user && current_user != post.trip.owner
  end

  def validate_part_of_trip 
    trip = Trip.find(params[:trip_id]) 
    redirect_to trip_path(trip), notice: "Must join trip to add posts" unless trip.includes_user?(current_user)
  end
end
