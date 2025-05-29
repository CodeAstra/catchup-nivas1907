class DailyDigestJob < ApplicationJob
  queue_as :default

  def perform
    User.where(daily_digest: true).find_each do |user|
      posts = user.my_feed.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).where.not(user_id: user.id)
      users_count = posts.select(:user_id).distinct.count
      posts_count = posts.count

      UserMailer.with(
        user: user,
        users_count: users_count,
        posts_count: posts_count
      ).daily_digest.deliver_now
    end
  end
end
