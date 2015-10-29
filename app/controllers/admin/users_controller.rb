class Admin::UsersController < AdminController

  def new
    @user = User.new
  end

  def create

  end

  def index
    @users = User.all.page(params[:page]).per(3)
  end

end