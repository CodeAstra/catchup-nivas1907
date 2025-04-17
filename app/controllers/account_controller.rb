class AccountController < ApplicationController
before_action :authenticate_user!

  def show
    @user=User.find(params[:id])
    @posts=@user.posts.order(created_at: :desc)
    @friends_count=@user.accepted_friends_ids.size
  end

  def edit
    @user=current_user
  end

  def update
    @user=User.find(params[:id])

    if @user.update(permit)
      respond_to do |format|
        format.html { redirect_to account_path(params[:id]) }
        format.turbo_stream { flash[:notice] = "Account details are successfully updated." }
      end
    else
      redirect_to edit_account_path
    end
  end

  def privacy
    val=(params[:user][:privacy_status].to_i)
    @user=current_user
    if current_user.privacy_update(val)
      respond_to do |format|
        format.html { redirect_to account_path(params[:id])  }
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

private

  def permit
    params.require(:user).permit(:username, :bio, :avatar, :status, :privacy_status)
  end
end
