class CommentsController < ApplicationController
  before_action :validate_comment_owner, only: [:edit,:update] #only post owners should be able to modify their posts
  before_action :validate_comment_owner_and_trip_owner, only: [:destroy] #trip owners should be able to delete posts
  before_action :validate_part_of_trip, only: [:new, :create]

  def new
    @post = Post.find(params[:post_id])
    @trip = @post.trip
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @trip = @post.trip
    @comment = @post.comments.build(comment_params)
    if @comment.valid?
      @comment.save
      redirect_to trip_post_path(@post.trip, @post)
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @trip = @post.trip
  end

  def update
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @trip = @post.trip
    if @comment.update(comment_params)
      redirect_to trip_post_path(@trip, @post)
    else
      render :edit
    end 
  end
  
  def destroy
    comment = Comment.find(params[:id])
    post = comment.post
    comment.destroy
    redirect_to trip_post_path(post.trip, post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end

  def validate_comment_owner
    comment = Comment.find(params[:id])
    redirect_to user_path(current_user) if current_user != comment.user
  end

  def validate_comment_owner_and_trip_owner
    comment = Comment.find(params[:id])
    redirect_to user_path(current_user) if current_user != comment.user && current_user != comment.post.trip.owner
  end

  def validate_part_of_trip
    post = Post.find(params[:post_id])
    redirect_to trip_path(post.trip), notice: "Must join trip to add comments" unless post.trip.includes_user?(current_user)
  end

end
