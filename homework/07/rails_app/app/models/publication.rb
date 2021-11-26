class Publication < ApplicationRecord
  belongs_to :author, class_name: 'Person', foreign_key: 'author_id'

  validates :title, presence: true

  def author_name
    author&.full_name
  end

  def author_school
    author&.school_name
  end

  def author_school_id
    author&.school_id
  end

  def author_id
    author&.id
  end

  def published
    published_at.before?(DateTime.now)
  end
end
