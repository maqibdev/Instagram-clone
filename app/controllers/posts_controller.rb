# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :post_find, only: %i[show edit update destroy]

  def index
    @posts = Post.order(updated_at: :desc).includes([:user])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    authorize @post
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    if @post.update(update_post_params)
      redirect_to @post
    else
      render 'new'
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content, pictures: [])
  end

  def update_post_params
    params.require(:post).permit(:content)
  end

  def post_find
    @post = Post.find(params[:id])
  end
end
