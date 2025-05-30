class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy

  validates :title, length: { minimum: 1, message: "title cant be empty" }
  validates :description, length: { minimum: 1, message: "description cant be empty" }

  def liked_by(user)
    likes.find_by(user_id: user.id)
  end
end
