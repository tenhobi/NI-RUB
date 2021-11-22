class Person < ApplicationRecord
  belongs_to :school
  has_many :publication, foreign_key: "author_id", dependent: :delete_all

  validates :full_name, presence: true
  validates :email, presence: true
  validates :username, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def school_name
    school&.name || '---'
  end

  def school_code
    school&.code || '---'
  end

  def school_id
    school&.id
  end
end
