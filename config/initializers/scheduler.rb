require "rufus-scheduler"

return unless Rails.env.development?

scheduler = Rufus::Scheduler.new

# Run DailyDigestJob every 30 seconds
scheduler.cron "46 15 * * *" do  # Every day at 20:00 (8 PM)
  Rails.logger.info "[RUFUS] Enqueuing DailyDigestJob at #{Time.current}"
  DailyDigestJob.perform_now
end
