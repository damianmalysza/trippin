class CommentsController < ApplicationController
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
end
