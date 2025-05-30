class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :posts
  has_many :sent_friendships, class_name: "Friendship", foreign_key: :sender_id
  has_many :received_friendships, class_name: "Friendship", foreign_key: :reciver_id

  enum :privacy_status, { everyone: 0, friends_only: 1, friends_of_friends: 2 }

  after_create :attach_default_avatar

  def accepted_friends_ids
    sent = Friendship.where(sender: self).accepted.pluck(:reciver_id)
    received = Friendship.where(reciver: self).accepted.pluck(:sender_id)
    sent + received
  end

  def pending_friends_ids
    received_friendships.pending.pluck(:sender_id)
  end

  def rejected_friends_ids
    received_friendships.rejected.pluck(:sender_id)
  end

  def one_layer_friends_ids
    ids = accepted_friends_ids
    second_layer_ids = Friendship.accepted.where(sender_id: ids).or(Friendship.accepted.where(reciver_id: ids)).pluck(:sender_id, :reciver_id).flatten
    (second_layer_ids - [ id ] - ids).uniq
  end


  def my_feed
    Post.where(user_id:  accepted_friends_ids << id).includes(:likes, user: :avatar_attachment).order(created_at: :desc)
  end

  def canishow(viewer)
    return true if id == viewer.id
    return true if everyone?
    return true if friends_only? && viewer.accepted_friends_ids.include?(id)
    return true if friends_of_friends? && (viewer.accepted_friends_ids.include?(id) || viewer.one_layer_friends_ids.include?(id))
    false
  end

  def name
    username || email.split("@").first
  end

  private

  def attach_default_avatar
    return if avatar.attached?

    default_image_path = Rails.root.join("app/assets/images/default-avatar.png")
    avatar.attach(
      io: File.open(default_image_path),
      filename: "default-avatar.png",
      content_type: "image/png"
    )
  end
end
