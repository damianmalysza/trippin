class SessionsController < ApplicationController
  def welcome
  end
  
  def login
  end

  def create
    user = User.find_by(username: params[:username])
    #add logic for if a user isn't find
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      #add error message if an incorrect password is provided
      redirect_to login_path
    end
  end

  def logout
    #add logic for logging out a user
  end
end
