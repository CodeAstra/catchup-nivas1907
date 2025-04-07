class Post < ApplicationRecord
  belongs_to :user
  has_many :like, dependent: :destroy
end
