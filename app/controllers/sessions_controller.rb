class SessionsController < ApplicationController
  def welcome
  end
  
  def login
    @user = User.new
  end

  def create
    binding.pry
  end

  def logout
  end
end
