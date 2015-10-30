class AdminController < ApplicationController
  before_action :require_admin

  def new
    @admin = User.new
    @admin.admin = true
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def impersonate_user
    session[:admin_user_id] = current_user.id 
    session[:user_id] = params[:id] # impersonating 
    redirect_to :root
  end

  def return_to_admin
    session[:user_id] = session[:admin_user_id] 
    session[:admin_user_id] = nil
    binding.pry
    redirect_to admin_users_path
  end

  helper_method :impersonate_user
  helper_method :return_to_admin
end