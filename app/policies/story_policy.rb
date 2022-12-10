# frozen_string_literal: true

class StoryPolicy
  attr_reader :current_user, :story

  def initialize(current_user, story)
    @current_user = current_user
    @story = story
  end

  def show?
    @story.first.user_id == @current_user.id || @story.first.user.status == 'open' || !@current_user.followings.find_by(
      followed_id: @story.first.user_id, status: true
    ).nil?
  end

  def destroy?
    @story.user_id == @current_user.id
  end
end
