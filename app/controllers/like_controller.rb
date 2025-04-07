class LikeController < ApplicationController
  def destroy
    @like=Like.all
    @like=Like.find_by(id: params[:id], post_id: params[:post_id])
    if @like.destroy
      puts "like removed"
      redirect_to post_index_path
    end
  end

  def create
    @like=Like.create(user_id: current_user.id, post_id: params[:post_id])
    if @like.save
      puts "like created"
      redirect_to post_index_path
    end
  end
end
