class HomeController < ApplicationController
  def index
    # Add your logic here
    if current_user
      @posts = current_user.my_feed
      @trending_score_hsh = {}
      @posts.each do |post|
        @trending_score_hsh[post.id] = {
          post: post,
          score: (post.likes_count * 3600 * 1000) / (Time.now - post.created_at).to_i }
        end
      @trending_score_hsh = @trending_score_hsh.sort_by { |k, v| -v[:score] }
    end
  end
end
