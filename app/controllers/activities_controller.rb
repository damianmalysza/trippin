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
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :location, :description, :cost, :date)
  end
end
