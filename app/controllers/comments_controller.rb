class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @trip = @post.trip
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    comment = Comment.create(comment_params)
    comment.user = current_user
    post.comments << comment 
    redirect_to trip_post_path(post.trip, post)
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @trip = @post.trip
  end

  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)
    redirect_to trip_post_path(comment.post.trip, comment.post)
  end
  
  def destroy
    comment = Comment.find(params[:id])
    post = comment.post
    comment.destroy
    redirect_to trip_post_path(post.trip, post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
