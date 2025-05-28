# app/jobs/daily_digest_job.rb
class DailyDigestJob < ApplicationJob
  queue_as :default

  def perform
    puts "Its working"
    user = User.first # or any logic to get the recipient
    users_count = User.count
    posts_count = Post.count

    UserMailer.with(
      user: user,
      users_count: users_count,
      posts_count: posts_count
    ).daily_digest.deliver_now
  end
end
