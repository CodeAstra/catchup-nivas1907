class PostsController < ApplicationController
  def show
  end
def index
  @user=User.all
  @like=Like.all
  @friends_id=Friendship.where(sender_id: current_user.id).accepted.pluck(:reciver_id)+Friendship.where(reciver_id: current_user.id).accepted.pluck(:sender_id)
  @user_posts=Post.where(user_id: current_user.id).order(created_at: :desc)
  @other_posts=Post.where(user_id: @friends_id).order(created_at: :desc)
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
  def create
    @user=current_user
      @post=@user.posts.create(post_params)

      if @post.save
        flash[:notice] = "Post successfully created"
        respond_to do |format|
          format.html { redirect_to posts_path }
          format.turbo_stream { flash[:notice] = notice }
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
  def post_params
    params.require(:post).permit(:title, :description)
  end
end
