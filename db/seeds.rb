require 'faker'

puts "Cleaning up database..."
Like.delete_all
Post.delete_all
Friendship.delete_all
User.delete_all

puts "Creating users..."
users = 200.times.map do
  full_name = Faker::Name.unique.name
  username = full_name.downcase.gsub(/\s+/, "_").gsub(/[^a-z0-9_]/, "")
  email = "#{username}@example.com"
  User.create!(
    email: email,
    username: full_name,
    password: "password",
    privacy_status: User.privacy_statuses.keys.sample,
    daily_digest: [ true, false ].sample
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
  150.times do
    Post.create!(
      user: user,
      title: Faker::Marketing.buzzwords.titleize,
      description: Faker::TvShows::GameOfThrones.quote
    )
  end
end

puts "Creating friendships..."
user_ids = users.map(&:id)
users.each do |user|
  friend_ids = user_ids.sample(rand(10..30)) - [ user.id ]
  friend_ids.each do |fid|
    next if Friendship.exists?(sender_id: user.id, reciver_id: fid) || Friendship.exists?(sender_id: fid, reciver_id: user.id)
    Friendship.create!(sender_id: user.id, reciver_id: fid, friendship_status: :accepted)
  end
end

puts "Creating likes on friends' posts..."
users.each do |user|
  if user.respond_to?(:accepted_friends_ids)
    friend_ids = user.accepted_friends_ids
  else
    friend_ids = Friendship.where(sender_id: user.id).pluck(:reciver_id) +
                 Friendship.where(reciver_id: user.id).pluck(:sender_id)
  end

  next if friend_ids.empty?

  Post.where(user_id: friend_ids).sample(50).each do |post|
    Like.find_or_create_by!(user_id: user.id, post_id: post.id)
  end
end

puts "Seeding complete! 🎉"
