class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy if @user
    flash[:notice] = "success"
    redirect_to admin_users_path
  end
end
