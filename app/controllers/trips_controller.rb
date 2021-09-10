class TripsController < ApplicationController

  def index
    if logged_in?
      @trips = current_user.trips
    else
      redirect_to root_path
    end
  end

  def new
    @trip = Trip.new
    @trip.activities.build
    @trip.posts.build
  end

  def create
    binding.pry
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
