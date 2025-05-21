class FriendRequestMailer < ApplicationMailer
  def new_request
    @sender = params[:user]
    @reciver = params[:friend]
    mail(to: @reciver.email, subject: "#{@sender.name} sent you a friend request")
  end

  def request_accepted
    @sender = params[:user]
    @reciver = params[:friend]
    mail(to: @sender.email, subject: "#{@reciver.name} accepted your friend request")
  end
end
