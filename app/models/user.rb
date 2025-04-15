class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :avatar

  has_many :posts
  has_many :sended, class_name: "Friendship", foreign_key: :sender_id
  has_many :recivied, class_name: "Friendship", foreign_key: :reciver_id

  enum :privacy_status, { public_state: 0, private_state: 1, protected_state: 2 }

  def confirmed_friends
    sent = Friendship.where(sender: self).accepted.pluck(:reciver_id)
    received = Friendship.where(reciver: self).accepted.pluck(:sender_id)
    User.where(id: sent + received)
  end

  def pending_friends
    ids=self.recivied.pending.pluck(:sender_id)
    User.where(id: ids)
  end
end
