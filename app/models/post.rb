class Post < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  has_many :comments

end
