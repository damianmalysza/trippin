class CommentsController < ApplicationController
  def new
    @trip = Trip.find(params[:trip_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    binding.pry
    post = Post.find(params[:post_id])
    comment = Comment.create(comment_params)
    comment.user = current_user
    post.comments << comment 
    redirect_to trip_post_path(post.trip, post)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
