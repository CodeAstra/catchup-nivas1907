class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post

  def create
    @like = @post.likes.create(user_id: current_user.id)
  end

  def destroy
    like = @post.likes.find_by(id: params[:id])
    like.destroy
  end

private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
