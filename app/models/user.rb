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
end
