class Activity < ApplicationRecord

  belongs_to :trip
  has_many :user_activities
  has_many :users, through: :user_activities

  validates :name, presence: true
  validate :valid_date?

  def act_date
    self.date.nil? ? "Date TBD" : self.date.strftime("%b. %d, %Y")
  end 

  def valid_date?
    trip = self.trip
    unless date > trip.start_date && date < trip.end_date
      errors.add(:date, "must be during trip")
    end
  end
end
