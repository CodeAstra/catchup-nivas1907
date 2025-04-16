class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :posts
  has_many :sent, class_name: "Friendship", foreign_key: :sender_id
  has_many :received, class_name: "Friendship", foreign_key: :reciver_id

  enum :privacy_status, { public_state: 0, private_state: 1, protected_state: 2 }

  def accepted_friends_ids
    sent = Friendship.where(sender: self).accepted.pluck(:reciver_id)
    received = Friendship.where(reciver: self).accepted.pluck(:sender_id)
    sent + received
  end

  def pending_friends_ids
    self.received.pending.pluck(:sender_id)
  end
  def my_feed
      Post.where(user_id: self.id).order(created_at: :desc) + Post.where(user_id: self.accepted_friends_ids).order(created_at: :desc)
  end
end
