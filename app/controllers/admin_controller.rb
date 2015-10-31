class AdminController < ApplicationController
  before_action :require_admin

  def new
    @admin = User.new
    @admin.admin = true
  end

  def require_admin
    unless current_user.admin? || session[:admin_user_id]
      redirect_to root_path
    end
  end

  def impersonate
    session[:admin_user_id] = current_user.id 
    session[:user_id] = params[:id] # impersonating 
    redirect_to :root
  end

  def return
    if session[:admin_user_id]
      session[:user_id] = session[:admin_user_id]
      session[:admin_user_id] = nil
    end   

    redirect_to admin_users_path
  end


  helper_method :impersonate
  helper_method :return
end