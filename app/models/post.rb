class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy

  validates :title, length: { minimum: 1, message: "title cant be empty" }
  validates :description, length: { minimum: 1, message: "description cant be empty" }
end
