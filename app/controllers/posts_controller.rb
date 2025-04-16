class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts=current_user.my_feed
  end

  def new
    @post=Post.new
  end

  def create
    @post=current_user.posts.create(post_params)
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream { flash[:notice] =   @post.valid? ? "Post successfully created": @post.errors.full_messages.to_sentence  }
    end
  end

  def edit
    @post=current_user.posts.find(params[:id])
  end

  def update
    # @user=current_user
    @post=Post.find(params[:id])
    @post.update(post_params)
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream { flash[:notice] = @post.valid? ? "Post successfully updated": @post.errors.full_messages.to_sentence }
    end
  end

  def cancel
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end

  def destroy
    @post=current_user.posts.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream { flash[:notice] = "Post was successfully deleted." }
    end
  end

  def trending
    @posts=current_user.my_feed
    @h = {}
    @posts.each do |p|
      @h[p.id]=((p.likes_count)*3600*1000/(Time.now-p.created_at)).round/10.0
    end
    @h=@h.sort_by { |k, v| -v }
  end

private

  def post_params
    params.require(:post).permit(:title, :description)
  end
end
