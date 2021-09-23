class Trip < ApplicationRecord
  
  #check on doing the owner thing
  
  has_many :user_trips
  has_many :users, through: :user_trips
  has_many :activities 
  has_many :posts
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  
  accepts_nested_attributes_for :activities, reject_if: :activity_atts_blank?
  accepts_nested_attributes_for :posts, reject_if: :post_atts_blank?
  
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :valid_date_range?
  
  def start
    self.start_date.strftime("%b. %d, %Y")
  end
  
  def end
    self.end_date.strftime("%b. %d, %Y")
  end 
  
  def total_cost
    cost = 0
    self.activities.each do |activity|
      cost += activity.cost
    end
    cost
  end 
  
  def activity_atts_blank?(att)
    att.values.all?("")
  end
  
  def post_atts_blank?(att)
    att["title"].blank? && att["content"].blank?
  end 
  
  def valid_date_range?
    if start_date && end_date
      if start_date >  end_date
        errors.add(:end_date, "must be after start date")
      end
    end 
  end
  
end
