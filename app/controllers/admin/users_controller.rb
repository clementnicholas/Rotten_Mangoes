class Admin::UsersController < AdminController

  def new
    
  end

  def create

  end

  def index
    @users = User.all
  end

end