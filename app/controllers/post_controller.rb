class PostController < ApplicationController
  def show
  end
def index
  @posts=Post.all
  @user=User.all
  @like=Like.all
  @user_posts=@posts.where(user_id: current_user.id).order(created_at: :desc)
  @other_posts=@posts.where.not(user_id: current_user.id).order(created_at: :desc)
  @posts=@user_posts+@other_posts
end
  def new
    @post=Post.new
  end
  def update
    @post=Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_index_path
    end
  end
  def create
    @user=current_user
    @post=@user.posts.create(post_params)
    if @post.save
      redirect_to post_index_path
    end
  end
  def edit
    @post=Post.find(params[:id])
  end
  def destroy
    @user=current_user
    @post=@user.posts.find(params[:id])
      if @post.destroy
        redirect_to post_index_path
      end
  end
  def post_params
    params.require(:post).permit(:title, :description)
  end
end
