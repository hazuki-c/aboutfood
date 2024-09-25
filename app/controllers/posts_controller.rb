class PostsController < ApplicationController

  def index
    
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  # 投稿データの保存
  def create
    @post = current_user.posts.build(post_params)
    # 画像があるかどうか
    if params[:post].present? && params[:post][:image].present?
      @post = Post.create(post_params)
    else
      @post = current_user.posts.build(post_params)
    end
    #リダイレクト先の指定
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    #@user = User.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
     if @post.update(post_params)
      flash[:notice] = "You have updated successfully."
      redirect_to post_path(@post.id)
     else
      render "edit"
     end
  end

  def destroy
    post = Post.find(params[:id])  # データを1件取得
    post.destroy  # データを削除
    redirect_to posts_path  # 投稿一覧画面へリダイレクト
  end

  # 投稿データのストロングパラメータ
  private
  def post_params
    params.permit(:title, :body)
  end
end