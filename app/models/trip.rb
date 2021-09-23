class Trip < ApplicationRecord

  #check on doing the owner thing

 has_many :user_trips
 has_many :users, through: :user_trips
 has_many :activities 
 has_many :posts
 belongs_to :owner, class_name: "User", foreign_key: "owner_id"

 accepts_nested_attributes_for :activities, reject_if: :activity_name_blank?
 accepts_nested_attributes_for :posts, reject_if: :post_atts_blank?

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

 def activity_name_blank?(att)
  att["name"].blank?
 end

 def post_atts_blank?(att)
  att["title"].blank? || att["content"].blank?
 end 

end
