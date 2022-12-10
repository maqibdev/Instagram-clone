# frozen_string_literal: true

module PostsHelper
  def request_accepted_or_not(value)
    current_user.followings.where(followed_id: value.id, status: true).empty?
  end
end
