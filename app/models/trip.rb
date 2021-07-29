class Trip < ApplicationRecord

  #check on doing the owner thing

 has_many :user_trips
 has_many :users, through: :user_trips
 has_many :activities 

end
