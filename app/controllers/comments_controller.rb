# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :post_find, only: %i[create destroy]
  before_action :comment_find, only: %i[edit update]

  def create
    @comment = @post.comments.create(comment_params)
    authorize @comment
    @comment.user_id = current_user.id
    redirect_to @post
    flash[:danger] = @comment.errors unless @comment.save
  end

  def edit
    authorize @comment
  end

  def update
    authorize @comment
    if @comment.update(comment_params)
      redirect_to @comment.post
    else
      render 'edit'
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def comment_find
    @comment = Comment.find(params[:id])
  end

  def post_find
    @post = Post.find(params[:post_id])
  end
end
