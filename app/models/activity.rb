class Activity < ApplicationRecord

  belongs_to :trip
  has_many :user_activities
  has_many :users, through: :user_activities

end
