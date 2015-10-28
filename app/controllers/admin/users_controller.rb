class Admin::UsersController < ApplicationController

  def new
    
  end

  def create

  end

  def index
    @users = User.all
  end

end