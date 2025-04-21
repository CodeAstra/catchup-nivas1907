class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy

  validates :title, length: { minimum: 1, message: "title cant be empty" }
  validates :description, length: { minimum: 1, message: "description cant be empty" }

  def post_trending_score
    (likes_count*3600*1000)/(Time.now-created_at).to_i
  end
end
