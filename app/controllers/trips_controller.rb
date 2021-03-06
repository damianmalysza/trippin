class TripsController < ApplicationController
  
  before_action :validate_trip_owner, only: [:edit, :update, :destroy]
  before_action :validate_user_join_or_create, only: [:join_trip, :leave_trip]

  def index
    @trips = Trip.future_trips
  end
  
  def new
    @trip = Trip.new
    @trip.activities.build
    @trip.posts.build
  end
  
  def create
    trip = Trip.new(trip_params)
    if trip.valid?
      trip.owner = current_user
      trip.save
      redirect_to trip_path(trip)
    else
      flash[:messages] = trip.errors.full_messages #rendering errors this way because i want to redirect to new action that builds on the activities and posts and will render the nested forms.
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
  
  def join_trip
    trip = Trip.find(params[:trip_id])
    trip.add_to_trip(@user)
    redirect_to trip_path(trip)
  end
  
  def leave_trip
    trip = Trip.find(params[:trip_id])
    trip.remove_from_trip(@user)
    redirect_to trip_path(trip)
  end
  
  
  private
  
  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, :owner_id, activities_attributes: [:name, :location, :description, :cost, :date], posts_attributes: [:title,:content,:user_id])
  end
  
  def validate_trip_owner
    trip = Trip.find(params[:id])
    redirect_to user_path(current_user) if current_user != trip.owner
  end
  
  def validate_user_join_or_create
    @user = User.find(params[:user_id]) 
    redirect_to user_path(current_user) if current_user != @user
  end
end
