class LikesController < ApplicationController
  def destroy
    @post=Post.find(params[:post_id])
    @like=@post.like.find_by(id: params[:id])
    if @like.destroy
      puts "like removed"
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.turbo_stream
      end
    end
  end

  def create
    @post=Post.find(params[:post_id])
    @like= @post.like.create(user_id: current_user.id)
    if @like.save
      puts "like created"
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.turbo_stream
      end
    end
  end
end
