class UsersController < ApplicationController
  def index
  end

  def create
    #need logic and alerting if username already exists
    if form_fields_completed?
      user ||= User.find_by(username: params[:user][:username])
      if user
        redirect_to new_user_path, notice: "Username already exists - please try another one"
      else
        user = User.create(user_params)
        session[:user_id] = user.id
        redirect_to user_path(user)
      end
    end

  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:username,:password)
  end

  def form_fields_completed?
      !params[:user][:username].nil? && !params[:user][:password].nil?
  end

  
end
