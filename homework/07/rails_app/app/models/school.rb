class School < ApplicationRecord
  has_many :person, dependent: :nullify

  validates :name, presence: true
  validates :code, presence: true
end
