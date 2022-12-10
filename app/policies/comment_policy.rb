# frozen_string_literal: true

class CommentPolicy
  attr_reader :current_user, :comment

  def initialize(current_user, comment)
    @current_user = current_user
    @comment = comment
  end

  def create?
    post_id = @comment.post.user_id
    post_id == @current_user.id || @comment.post.user.status == 'open' || !@current_user.followings.find_by(
      followed_id: post_id, status: true
    ).nil?
  end

  def edit?
    @comment.user_id == @current_user.id
  end

  def update?
    @comment.user_id == @current_user.id
  end

  def destroy?
    @comment.user_id == @current_user.id || @comment.post.user_id == current_user.id
  end
end
