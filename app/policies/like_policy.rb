# frozen_string_literal: true

class LikePolicy
  attr_reader :current_user, :like

  def initialize(current_user, like)
    @current_user = current_user
    @like = like
  end

  def destroy?
    @like.user_id == current_user.id
  end
end
