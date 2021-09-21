class ActivitiesController < ApplicationController
  def index
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @activity = Activity.new
  end
  
  def create
    trip = Trip.find(params[:trip_id])
    activity = Activity.create(activity_params)
    trip.activities << activity
    redirect_to trip_path(trip)
  end
  
  def show
    @trip = Trip.find(params[:trip_id])
    @activity = Activity.find(params[:id]) 
  end
  
  def edit
    @trip = Trip.find(params[:trip_id])
    @activity = Activity.find(params[:id])
  end

  def update
    activity = Activity.find(params[:id])
    activity.update(activity_params)
    redirect_to trip_activity_path(activity.trip, activity)
  end

  def destroy
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :location, :description, :cost, :date)
  end
end
