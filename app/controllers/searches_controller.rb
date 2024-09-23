class SearchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where("name LIKE ?", "%#{params[:word]}%")
    @posts = Post.where("title LIKE ?", "%#{params[:word]}%").or(
      Post.where("body LIKE ?", "%#{params[:word]}%"))

  end
  
  def form
    @word = params[:search][:word]
  end
  
end