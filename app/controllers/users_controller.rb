class UsersController < ApplicationController
  def index
  end

  def create
    #need logic and alerting if username already exists
    user = User.create(user_params)
    session[:user_id] = user.id
    redirect_to user_path(user)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:username,:password)
  end

  
end
