# frozen_string_literal: true

class Story < ApplicationRecord
  belongs_to :user
  has_one_attached :storyimage
  validates :storyimage, presence: true
  validate :storyimage_type

  after_commit do
    DeleteStoryJob.set(wait: 5.minutes).perform_later(id)
  end

  private

  def storyimage_type
    return if storyimage.content_type.in?(%('image/jpeg image/png'))

    storyimage.errors.add(:storyimage,
                          'need to be a JPEG or PNG')
  end
end
