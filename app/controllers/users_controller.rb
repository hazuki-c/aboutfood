class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit]  
  
  def mypage
    @user = current_user
    @posts = @user.posts
  end
  
  def show
    @user = User.find(params[:id])
    @posts =Post.all
  end
  
  def edit
    # 編集するユーザーが本人じゃない場合はユーザーページにリダイレクトする
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end
  
  def update
    @user = User.find(params[:id])
    # アップデートがうまくいけば、マイページに戻利、
    # うまくいかなければ、もう一度編集ページを表示する
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to mypage_path
    else
      render "edit" 
    end
  end
  
  def favorites
    @user = User.find(params[:id])
    @posts = @user.favorite_posts
  end
  
  private
  
    def set_user
      @user = User.find(params[:id])
      if current_user != @user
        redirect_to user_path(current_user.id), notice: "他人のユーザ情報編集画面にはアクセスできません"
      end
    end

    def user_params
      params.fetch(:user, {}).permit(:name, :introduction, :profile_image)
    end

end
