module ApplicationHelper
  include Pagy::Frontend
  def render_turbo_stream_flash_message
    turbo_stream.update "flash", partial: "layouts/flash"
  end
end
