class SessionsController < ApplicationController
  def welcome
  end
  
  def login
    #todo: add option to log in with 3rd party
  end

  def create
    #need to update with omniauth logic
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
    else
      redirect_to login_path, notice: "Required fields not completed"
    end 

  end

  def logout
    #add logic for logging out a user
  end
end
