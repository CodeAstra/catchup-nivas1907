class AccountController < ApplicationController
  def show
    @user=User.find(params[:id])
    @posts=Post.where(user_id: @user).order(created_at: :desc)
    @like=Like.all
    @friends_count=Friend.where(user_id: @user.id, status: "accepted").count+Friend.where(friend_id: @user.id, status: "accepted").count
  end
  def update
    @user=User.find(params[:id])

    if @user.update(permit)
      respond_to do |format|
        format.html { redirect_to account_path(params[:id]), notice: "account details are successfully updated."  }
        format.turbo_stream { flash[:notice] = "Account details are successfully updated." }
      end
    else
      redirect_to edit_account_path
    end
  end
  def privacy
    val=(params[:user][:privacy_status].to_i)
    @user=User.find(current_user.id)
    if @user.update(privacy_status: val)
      respond_to do |format|
        format.html { redirect_to account_path(params[:id]) , notice: "privacy option is successfully updated."  }
        format.turbo_stream { flash[:notice] = "Privacy option is successfully updated." }
      end
    end
  end
  def cancel
    @user=User.find(current_user.id)
    respond_to do |format|
      format.html { redirect_to account_path(current_user.id) }
      format.turbo_stream
    end
  end
  def edit
    @user=User.find(params[:id])
  end
  def permit
    params.require(:user).permit(:username, :bio, :avatar, :status, :privacy_status)
  end
end
