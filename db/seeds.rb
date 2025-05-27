# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
require 'faker'

puts "Cleaning up database..."
Like.delete_all
Post.delete_all
Friendship.delete_all
User.delete_all

puts "Creating users..."
users = 50.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    username: Faker::Internet.username,
    password: "password",
    privacy_status: User.privacy_statuses.keys.sample
  )
end

puts "Attaching avatars..."
users.each do |user|
  user.avatar.attach(
    io: File.open(Rails.root.join("app/assets/images/default-avatar.png")),
    filename: "default-avatar.png",
    content_type: "image/png"
  )
end

puts "Creating posts..."
users.each do |user|
  rand(5..10).times do
    Post.create!(
      user: user,
      title: Faker::Lorem.sentence(word_count: 3),
      description: Faker::Lorem.paragraph(sentence_count: 2)
    )
  end
end

puts "Creating friendships..."
user_ids = users.map(&:id)
users.each do |user|
  friend_ids = user_ids.sample(rand(5..10)) - [user.id]
  friend_ids.each do |fid|
    next if Friendship.exists?(sender_id: user.id, reciver_id: fid) || Friendship.exists?(sender_id: fid, reciver_id: user.id)
    Friendship.create!(sender_id: user.id, reciver_id: fid, friendship_status: :accepted)
  end
end

puts "Creating likes on friends' posts..."
users.each do |user|
  friend_ids = user.accepted_friends_ids
  Post.where(user_id: friend_ids).sample(rand(10..20)).each do |post|
    Like.create!(post: post)
  end
end

