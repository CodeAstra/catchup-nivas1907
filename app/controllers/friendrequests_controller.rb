class FriendrequestsController < ApplicationController
  def index
    @pending_list=Friendship.where(reciver_id: current_user, status: "pending")
    @pending_list_count=@pending_list.count
  end

  def update
    if Friendship.find(params[:id]).update(status: "accepted")
      respond_to do |format|
        format.html { redirect_to friends_path, notice: "Friend request accepted." }
        format.turbo_stream {  flash[:notice] = "Friend request accepted." }
      end
    end
  end
  def destroy
    @user=User.find(params[:sender_id])
    if Friendship.destroy(params[:id])
      respond_to do |format|
        format.html { redirect_to friends_path, notice: "Friend request rejected." }
        format.turbo_stream { flash[:notice] = "Friend request rejected." }
      end
    end
  end
end
