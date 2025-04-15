class FriendrequestsController < ApplicationController
  def index
    @pendingfriends=current_user.pendingFriends
  end

  def update
    if Friendship.find(params[:id]).updatestate("accepted")
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
