class PostsController < ApplicationController
  def show
  end
def index
  @posts=Post.all
  @user=User.all
  @like=Like.all
  @friends_id=Friend.where(user_id: current_user.id, status: "accepted").pluck(:friend_id)+Friend.where(friend_id: current_user.id, status: "accepted").pluck(:user_id)
  @user_posts=@posts.where(user_id: current_user.id).order(created_at: :desc)
  @other_posts=@posts.where(user_id: @friends_id).order(created_at: :desc)
  @posts=@user_posts+@other_posts
end
  def new
    @post=Post.new
  end
  def update
    @user=current_user
  
    @post=Post.find(params[:id])
    if @post.update(post_params)
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.turbo_stream
      end
    end
  end
  def cancel
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end
  def create
    @user=current_user
    @post=@user.posts.create(post_params)
    if @post.save
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.turbo_stream
      end
    end
  end
  def edit
    @post=Post.find(params[:id])
  end
  def destroy
    @user=current_user
    @post=@user.posts.find(params[:id])
      if @post.destroy
        respond_to do |format|
          format.html { redirect_to posts_path }
          format.turbo_stream
        end
      end
  end
  def post_params
    params.require(:post).permit(:title, :description)
  end
end
