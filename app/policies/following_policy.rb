# frozen_string_literal: true

class FollowingPolicy
  attr_reader :current_user, :following

  def initialize(current_user, following)
    @current_user = current_user
    @following = following
  end

  def update?
    @following.followed_id == current_user.id
  end

  def destroy?
    @following.user_id == current_user.id
  end

  def decline_request?
    @following.followed_id == current_user.id
  end
end
