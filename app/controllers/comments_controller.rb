class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @trip = @post.trip
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.build(comment_params)
    if post.valid?
      post.save
      redirect_to trip_post_path(post.trip, post)
    else
      flash[:messages] = comment.errors.full_messages
      redirect_to new_trip_post_comment_path(post.trip, post)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @trip = @post.trip
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update(comment_params)
      redirect_to trip_post_path(comment.post.trip, comment.post)
    else
      flash[:messages] = comment.errors.full_messages
      redirect_to edit_trip_post_comment_path(comment.post.trip, comment.post)
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
end
