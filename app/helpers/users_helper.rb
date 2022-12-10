# frozen_string_literal: true

module UsersHelper
  def currentuser_or_not?(value)
    current_user.id == value.id
  end

  def status_follow_or_not?(value)
    current_user.followings.empty? || current_user.followings.find_by(followed_id: value.id).nil?
  end

  def status_public_or_not?(value)
    current_user.followings.find_by(followed_id: value.id).status == true
  end

  def follower_or_not?(value)
    (value.status == 'close' && current_user.followings.find_by(followed_id: value.id,
                                                                status: true).nil?)
  end

  def private_or_not?(value)
    value.status == 'open' || !follower_or_not?(value) || value.id == current_user.id ? true : false
  end

  def followers_count(user)
    Following.where(followed_id: user, status: 'true').count
  end

  def followed_count(user)
    user.followings.where(status: 'true').count
  end
end
