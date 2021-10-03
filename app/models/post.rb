class Post < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
end
