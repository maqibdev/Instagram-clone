# frozen_string_literal: true

class DeleteStoryJob < ApplicationJob
  queue_as :default

  def perform(id)
    temp = Story.find(id)
    temp.destroy
  end
end
