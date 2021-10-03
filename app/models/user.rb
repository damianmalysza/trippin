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
  
  def delete_user
    self.owned_trips.each {|trip| trip.destroy}
    self.non_owned_trips.each {|trip| trip.remove_from_trip(self)}
    self.posts.each {|post| post.destroy}
    self.comments.each {|cmt| cmt.destroy}
    self.destroy
  end 
  
  def self.create_from_oauth(omniauth_details)
    user = User.find_or_create_by(uid: omniauth_details['uid'])
    user.username = omniauth_details['info']['nickname'] 
    user.password_digest = SecureRandom.urlsafe_base64
    user.save
    user
  end 

  
end
