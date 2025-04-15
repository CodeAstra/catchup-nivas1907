class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :posts
  has_many :friendships
  has_many :senders, class_name: "Friendship", foreign_key: :sender_id
  has_many :recivers, class_name: "Friendship", foreign_key: :reciver_id
  enum :privacy_status, { public_state: 0, private_state: 1, protected_state: 2 }
  def friends
    sent=Friendship.where(sender_id: self.id, status: "accepted").pluck(:reciver_id)
    received=Friendship.where(reciver_id: self.id, status: "accepted").pluck(:sender_id)
    User.where(id: sent+received)
  end
end
