class User < ApplicationRecord
  has_secure_password

  has_many :user_trips
  has_many :trips, through: :user_trips
  has_many :user_activities
  has_many :activities, through: :user_activities
  has_many :comments
  has_many :posts

  validates :username, presence: true
  validates :username, uniqueness: true

  def owned_trips
    Trip.all.select {|trip| trip.owner == self}
  end

  def non_owned_trips
    Trip.all.select {|trip| trip.users.include?(self) && trip.owner != self}
  end

end
