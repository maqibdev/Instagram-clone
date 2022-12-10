# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @following = Following.find_by(user_id: @user.id)
  end

  def follow_request
    @follow = current_user.followed_requests_received
  end

  def search
    @user = User.text_search(params[:query])
  end

  private

  def user_params
    params.require(:user).permit(:id)
  end
end
