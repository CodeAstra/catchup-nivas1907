class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post

  def create
    @like= @post.likes.create(user_id: current_user.id)
    flash[:notice]="Liked the post"
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end

  def destroy
    @like=@post.likes.find_by(id: params[:id])
    @like.destroy
    flash[:notice]="Unliked the post"
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.turbo_stream
    end
  end

private

  def find_post
    @post=Post.find(params[:post_id])
  end
end
