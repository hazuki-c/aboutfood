class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @comments = Comment.all
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy if @comment
    flash[:notice] = "success"
    redirect_to admin_comments_path
  end
end
