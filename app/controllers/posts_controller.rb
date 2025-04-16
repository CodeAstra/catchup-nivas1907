class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user=User.all
    @user_posts=current_user.posts
    @other_posts=Post.where(user_id: current_user.accepted_friends).order(created_at: :desc)
    @posts=@user_posts+@other_posts
  end

  def new
    @post=Post.new
  end

  def create
    @user=current_user
      @post=@user.posts.create(post_params)
      if @post.save
        respond_to do |format|
          format.html { redirect_to posts_path }
          format.turbo_stream { flash[:notice] = "Post successfully created" }
        end
      else
        respond_to do |format|
          format.html { redirect_to posts_path }
          format.turbo_stream { flash[:notice] = "Post field can't be empty." }
        end

      end
  end

  def edit
    @post=Post.find(params[:id])
  end

  def update
    @user=current_user
      @post=Post.find(params[:id])
      if @post.update(post_params)
        respond_to do |format|
          format.html { redirect_to posts_path }
          format.turbo_stream { flash[:notice] = "Post was successfully updated." }
        end
      else
        respond_to do |format|
          format.html { redirect_to posts_path }
          format.turbo_stream { flash[:notice] = "Post field can't be empty." }
        end
      end
  end

  def cancel
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end

  def destroy
    @user=current_user
    @post=@user.posts.find(params[:id])
      if @post.destroy
        respond_to do |format|
          format.html { redirect_to posts_path }
          format.turbo_stream { flash[:notice] = "Post was successfully deleted." }
        end
      end
  end

  def trending
    @posts=Post.all
    @allp=Post.all
    @friends_id=current_user.accepted_friends
    @user_posts=current_user.posts
    @other_posts=@posts.where(user_id: @friends_id).order(created_at: :desc)
    @posts=@user_posts+@other_posts
    @h = {}
    @posts.each do |p|
      @h[p.id]=((p.likes_count)*3600*1000/(Time.now-p.created_at)).round/10.0
    end
    @h=@h.sort_by { |k, v| -v }
  end

  def post_params
    params.require(:post).permit(:title, :description)
  end
end
