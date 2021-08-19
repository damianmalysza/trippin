class SessionsController < ApplicationController
  def welcome
  end
  
  def login
    #todo: add option to log in with 3rd party
  end

  def create
    if login_fields_completed?
      user = User.find_by(username: params[:username])
      if user
        if user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to user_path(user)
        else
          #add error message if an incorrect password is provided
          redirect_to login_path
        end
      else
        #add error logic for if a user isn't found
        redirect_to login_path
      end 
    else
      #add error logic for if required fields aren't completed
      redirect_to login_path

  end

  def logout
    #add logic for logging out a user
  end
end
