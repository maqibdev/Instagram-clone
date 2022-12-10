# frozen_string_literal: true

class FollowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_following, only: %i[update decline_request]

  def create
    @following = current_user.followings.create(following_params)
    @following.user_id = current_user.id
    @following.followed_id = params[:user_id]
    @following.status = User.find(following_params[:user_id]).status == 'open' ? 'true' : 'false'
    @following.save
    redirect_to user_path(following_params[:user_id])
  end

  def update
    authorize @following
    @following.status = 'true'
    redirect_to follow_request_user_path(current_user) if @following.save
  end

  def destroy
    @following = current_user.followings.find_by!(followed_id: following_params_id)
    authorize @following
    @following.destroy
    redirect_to user_path(following_params_id)
  end

  def decline_request
    authorize @following
    @following.destroy
    redirect_to follow_request_user_path(current_user.id)
  end

  private

  def following_params
    params.permit(:user_id)
  end

  def following_params_id
    params.permit(:id)[:id]
  end

  def find_following
    @following = current_user.followed_requests_received.find_by!(user_id: following_params_id)
  end
end
