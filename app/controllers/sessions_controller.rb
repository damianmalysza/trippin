class SessionsController < ApplicationController

  skip_before_action :require_login

  def welcome
    redirect_to user_path(current_user) if logged_in?
  end
  
  def login
    redirect_to user_path(current_user) if logged_in?
  end

  def create
    if login_fields_completed?
      user = User.find_by(username: params[:username])
      if user
        if user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to user_path(user)
        else
          redirect_to login_path, notice: "Incorrect Username or Password"
        end
      else
        redirect_to login_path, notice: "Incorrect Username or Password"
      end
    elsif omniauth_details
      user = User.create_from_oauth(omniauth_details)
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      redirect_to login_path, notice: "Required fields not completed"
    end 

  end

  def logout
    session.clear
    redirect_to root_path
  end

  private

  def omniauth_details
    request.env['omniauth.auth']
  end

  def login_fields_completed?
    !params[:username].nil? && !params[:password].nil?
  end

end
