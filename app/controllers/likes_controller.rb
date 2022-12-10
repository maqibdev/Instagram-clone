# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post_like, only: [:create]
  before_action :find_like, only: [:destroy]
  include LikesHelper

  def create
    if like_or_not?(@data)
      @like = Like.create(like_param)
      @like.user_id = current_user.id
      @like.save
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    authorize @like
    @temp = @like.post
    @like.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def like_param
    params.permit(:post_id)
  end

  def find_post_like
    @data = like_param[:post_id].to_i
    @temp = Post.find(like_param[:post_id])
  end

  def find_like
    @like = Like.find(params.permit(:id)[:id])
  end
end
