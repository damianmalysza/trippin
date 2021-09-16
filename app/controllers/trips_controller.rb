class TripsController < ApplicationController
  
  def index

  end
  
  def new
    @trip = Trip.new
    @trip.activities.build
    @trip.posts.build
  end
  
  def create #TODO - figure out how to handle users that don't want to submit activity or posts
    trip = Trip.create(trip_params)
    trip.posts.first.user = current_user 
    trip.owner_id = current_user.id
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
