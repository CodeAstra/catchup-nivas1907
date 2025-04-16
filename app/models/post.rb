class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy

  validates :title, length: { minimum: 1 }
  validates :description, length: { minimum: 1 }
end
