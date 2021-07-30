class UsersController < ApplicationController
  def index
  end

  def create
    #need logic for how to handle OAuth
    #need logic and alerting if username already exists
    user = User.create(user_params)
    session[:user_id] = user.id
    redirect_to '/' #change this redirect eventually
  end

  def new
    @user = User.new
  end

  def edit
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
