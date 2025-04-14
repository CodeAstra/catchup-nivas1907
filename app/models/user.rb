class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :avatar
  has_many :posts
  has_many :senders, class_name: "Friendship", foreign_key: :sender_id
  has_many :recivers, class_name: "Friendship", foreign_key: :reciver_id
  scope  :friends, -> { join(:friendship).where(friendship: { status: "accepted" }) }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum :privacy_status, { public_state: 0, private_state: 1, protected_state: 2 }
end
