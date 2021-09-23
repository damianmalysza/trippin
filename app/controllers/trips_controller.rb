class TripsController < ApplicationController
  
  def index

  end
  
  def new
    @trip = Trip.new
    @trip.activities.build
    @trip.posts.build
  end
  
  def create
    trip = Trip.create(trip_params)
    trip.owner = current_user
    if trip.save
      redirect_to trip_path(trip)
    else
      redirect_to new_trip_path
    end
  end
  
  def show
    @trip = Trip.find(params[:id])
  end
  
  def edit
    @trip = Trip.find(params[:id]) 
  end
  
  def update
   trip = Trip.find(params[:id])
   trip.update(trip_params)
   redirect_to trip_path(trip)
  end
  
  def destroy
   trip = Trip.find(params[:id])
   trip.destroy
   redirect_to root_path
  end
  
  
  private
  
  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, activities_attributes: [:name, :location, :description, :cost, :date], posts_attributes: [:title,:content,:user_id])
  end
end
