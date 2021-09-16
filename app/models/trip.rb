class Trip < ApplicationRecord

  #check on doing the owner thing

 has_many :user_trips
 has_many :users, through: :user_trips
 has_many :activities 
 has_many :posts

 accepts_nested_attributes_for :activities
 accepts_nested_attributes_for :posts

 def owner_id=(id)
  user = User.find(id)
  if user
    self[:owner_id] = id
    user.trips << self
  end
 end
 
 def owner
  User.find(self[:owner_id])
 end 

 def start
  self.start_date.strftime("%b. %d, %Y")
 end

 def end
  self.end_date.strftime("%b. %d, %Y")
 end 

end
