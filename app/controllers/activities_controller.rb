class ActivitiesController < ApplicationController
  before_action :validate_part_of_trip, only: [:new, :create]

  def index
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @activity = Activity.new
  end
  
  def create
    @trip = Trip.find(params[:trip_id])
    @activity = @trip.activities.build(activity_params)
    if @activity.valid?
      @activity.save
      redirect_to trip_path(@trip)
    else
      render :new
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
    @activity = Activity.find(params[:id])
    @trip = @activity.trip
    if @activity.update(activity_params)
      redirect_to trip_activity_path(@trip, @activity)
    else
      render :edit
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

  def validate_part_of_trip
    trip = Trip.find(params[:trip_id]) 
    redirect_to trip_path(trip), notice: "Must join trip to add activities" unless trip.includes_user?(current_user)
  end
end
