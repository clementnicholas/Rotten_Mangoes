class My::BaseController < ApplicationController

  before_filter :ensure_logged_in

  protected

  def ensure_logged_in
    redirect_to root_path, notice: 'Please Log In' unless current_user
  end

end