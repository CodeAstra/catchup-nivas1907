class DailyMailerJob
  include Sidekiq::Job

  def perform
    UserMailer.daily_email(User.first).deliver_now
  end
end
