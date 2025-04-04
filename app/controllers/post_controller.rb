class PostController < ApplicationController
  def show
  end
def index
  @posts=Post.all
  @user=User.all
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
    
  end
  def post_params
    params.require(:post).permit(:title, :description)
  end
end
