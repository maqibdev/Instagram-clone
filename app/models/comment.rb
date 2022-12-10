# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true, length: { maximum: 100, too_long: ' Max Limit is 100' }
end
