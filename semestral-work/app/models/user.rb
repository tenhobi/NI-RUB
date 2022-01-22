class User < ApplicationRecord
  has_one_attached :image
  has_many :posts, dependent: :delete_all

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
  validates :display_name, length: { maximum: 30 }
  validates :description, length: { maximum: 300 }
  validates :image, presence: true
end
