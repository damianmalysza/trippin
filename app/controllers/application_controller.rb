class ApplicationController < ActionController::Base

  helper_method :current_user
  helper_method :logged_in?
  
  before_action :require_login

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def require_login
    unless logged_in?
      redirect_to login_path, notice: "Please log in to use the app"
    end
  end

end
