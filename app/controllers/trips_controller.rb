class TripsController < ApplicationController
  
  def index
    if logged_in?
      @trips = current_user.trips
    else
      redirect_to root_path
    end
  end
  
  def new
    @user = User.find(params[:user_id])
    if @user == current_user
      @trip = Trip.new
      @trip.activities.build
      @trip.posts.build
    else
      redirect_to root_path
    end
  end
  
  def create
    user = User.find(params[:user_id])
    if user == current_user
      trip = Trip.create(trip_params)
      trip.owner_id = current_user.id
      trip.posts.first.user = current_user 
      if trip.save
        redirect_to user_trip_path(user,trip)
      else
        redirect_to new_trip_path
      end
    else
      redirect_to root_path
    end
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  
  private
  
  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, activities_attributes: [:name, :location, :description, :cost, :date], posts_attributes: [:title,:content])
  end
  
end
