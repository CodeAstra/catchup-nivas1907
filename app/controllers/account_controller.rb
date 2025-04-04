class AccountController < ApplicationController
  def show
    @posts=Post.where(user_id: current_user.id).order(created_at: :desc)
    @like=Like.all
  end
  def update
    @user=User.find(params[:id])

    if @user.update(permit)
      redirect_to account_path
    else
      redirect_to edit_account_path
    end
  end
  def edit
    @user=User.find(params[:id])
  end
  def permit
    params.require(:user).permit(:username, :bio, :avatar)
  end
end
