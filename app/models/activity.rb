class Activity < ApplicationRecord

  belongs_to :trip
  has_many :user_activities
  has_many :users, through: :user_activities

  validates :name, presence: true

  def act_date
    self.date.nil? ? "Date TBD" : self.date.strftime("%b. %d, %Y")
  end 

end
