# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_stories, only: [:show]
  before_action :find_story, only: [:destroy]

  def new
    @story = current_user.stories.build
  end

  def create
    @story = current_user.stories.create(story_params)
    if @story.save
      redirect_to @story
    else
      render 'new'
    end
  end

  def show
    authorize @stories
  end

  def destroy
    authorize @story
    @story.destroy
    redirect_to user_path(@story.user.id)
  end

  private

  def story_params
    params.require(:story).permit(:storyimage)
  end

  def find_story
    @story = Story.find(params[:id])
  end

  def find_stories
    @stories = Story.find(params[:id]).user.stories
  end
end
