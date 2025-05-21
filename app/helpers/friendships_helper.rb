module FriendshipsHelper
  def turbo_reference_key(friendship, referer)
    page = referer.to_s.split("/").last

    case page
    when "new"
      "friends_#{friendship.sender_id}"
    when "pending_requests"
      "pendingpage_#{friendship.sender_id}"
    when "rejected_requests"
      "rejectedpage_#{friendship.sender_id}"
    else
      "accountpage_#{friendship.sender_id}"
    end
  end
end
