# frozen_string_literal: true

module LikesHelper
  def like_get(data)
    current_user.like.find_by(post_id: data)
  end

  def like_or_not?(data)
    value = like_get(data)
    value.nil?
  end
end
