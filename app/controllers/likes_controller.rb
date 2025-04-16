class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @post=Post.find(params[:post_id])
    @like= @post.likes.create(user_id: current_user.id)
    flash[:notice] = "Liked the post"
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end

  def destroy
    @post=Post.find(params[:post_id])
    @like=@post.likes.find_by(id: params[:id])
    @like.destroy
    flash[:notice] = "Unliked the post"
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end
end
