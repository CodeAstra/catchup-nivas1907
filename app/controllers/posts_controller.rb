class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_posts, only: [ :edit, :update, :destroy ]

  def index
    @posts = current_user.my_feed
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)

    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end

  def edit; end

  def update
    @update_success = @post.update(post_params)

    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end

  def destroy
    @destroy_success = @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end

  def cancel
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end


  def trending
    @posts = current_user.my_feed
    @trending_score_hsh={}
    @posts.each do |post|
      @trending_score_hsh[post.id] = post.post_trending_score
    end
    @trending_score_hsh = @trending_score_hsh.sort_by { |k, v| -v }
  end

private

  def post_params
    params.require(:post).permit(:title, :description)
  end

  def get_posts
    @post=current_user.posts.find(params[:id])
  end
end
