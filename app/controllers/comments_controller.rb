class CommentsController < ApplicationController
  def index
    @comments = Comment.all
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
  
  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy if @comment
    flash[:success] = "削除しました"
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
