# frozen_string_literal: true

class PostPolicy
  attr_reader :current_user, :post

  def initialize(current_user, post)
    @current_user = current_user
    @post = post
  end

  def show?
    @post.user_id == @current_user.id || @post.user.status == 'open' || !@current_user.followings.find_by(
      followed_id: @post.user_id, status: true
    ).nil?
  end

  def edit?
    @post.user_id == @current_user.id
  end

  def update?
    @post.user_id == @current_user.id
  end

  def destroy?
    @post.user_id == @current_user.id
  end
end
