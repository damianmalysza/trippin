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

end
