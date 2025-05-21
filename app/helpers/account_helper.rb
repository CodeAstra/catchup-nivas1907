module AccountHelper
  def canishow(id)
    (id == current_user.id) || User.find(id).public_state? || (User.find(id).private_state? && current_user.accepted_friends_ids.include?(id)) || (User.find(id).protected_state? && (current_user.accepted_friends_ids.include?(id)) || (current_user.one_layer_friends_ids.include?(id)))
  end
end
