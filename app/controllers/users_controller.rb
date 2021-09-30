class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    if logged_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end    
  end
  
  
  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def update
    user = User.find(params[:id])
    new_name = params[:user][:username]
    if User.find_by(username: new_name)
      redirect_to edit_user_path(user), notice: "Username already exists - please try another one"
    else
      user.update(user_params)
      user.save
      redirect_to user_path(user)
    end 
  end
  
  def destroy
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user)
    else
      session.clear
      user.delete
      redirect_to root_path
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username,:password)
  end
  
  def form_fields_completed?
    !params[:user][:username].nil? && !params[:user][:password].nil?
  end
  
  
end
