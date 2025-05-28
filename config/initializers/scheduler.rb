require "rufus-scheduler"

return unless Rails.env.development?

scheduler = Rufus::Scheduler.new

# Run DailyDigestJob every 30 seconds
scheduler.every "30s" do
  Rails.logger.info "[RUFUS] Enqueuing DailyDigestJob at #{Time.current}"
  DailyDigestJob.perform_now
end
