# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :pictures
  validates :pictures, presence: true, length: { maximum: 10, too_long: ' Max Limit is 10' }
  validate :image_type
  validates :content, length: { maximum: 100, too_long: ' Max Limit is 100' }

  private

  def image_type
    pictures.each do |image|
      errors.add(:pictures, 'need to be a JPEG or PNG') unless image.content_type.in?(%('image/jpeg image/png'))
    end
  end
end
