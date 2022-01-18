class Post < ApplicationRecord
  has_one_attached :image
  has_many :tags
  belongs_to :user

  validates :image, presence: true
  validates :user, presence: true
end
