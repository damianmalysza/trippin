class ActivitiesController < ApplicationController
  def index
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @activity = Activity.new
  end
  
  def create
    trip = Trip.find(params[:trip_id])
    trip.activities.build(activity_params)
    if trip.valid?
      trip.save
      redirect_to trip_path(trip)
    else
      flash[:messages] = trip.errors.full_messages
      redirect_to new_trip_activity_path(trip)
    end
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
    if activity.update(activity_params)
      redirect_to trip_activity_path(activity.trip, activity)
    else
      flash[:messages] = activity.errors.full_messages
      redirect_to edit_trip_activity_path(activity.trip)
    end 
  end

  def destroy
    activity = Activity.find(params[:id])
    trip = activity.trip
    activity.destroy
    redirect_to trip_path(trip)
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :location, :description, :cost, :date)
  end
end
