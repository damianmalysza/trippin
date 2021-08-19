class ApplicationController < ActionController::Base

  helper_method :current_user
  helper_method :logged_in?
  helper_method :login_fields_completed?

  def current_user
    User.find(session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def login_fields_completed?
    !params[:username].nil? && !params[:password].nil?
  end

end
