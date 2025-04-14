class TrendingController < ApplicationController
  def index
    @posts=Post.all
    @allp=Post.all
    @user=User.all
    @like=Like.all
    @friends_id=Friendship.where(sender_id: current_user.id, status: "accepted").pluck(:reciver_id)+Friendship.where(reciver_id: current_user.id, status: "accepted").pluck(:sender_id)
    @user_posts=@posts.where(sender_id: current_user.id).order(created_at: :desc)
    @other_posts=@posts.where(sender_id: @friends_id).order(created_at: :desc)
    @posts=@user_posts+@other_posts
    @h = {}
    @posts.each do |p|
      @h[p.id]=((p.like.count)*3600*1000/(Time.now-p.created_at)).round/10.0
    end
    @h=@h.sort_by { |k, v| -v }
  end
end
