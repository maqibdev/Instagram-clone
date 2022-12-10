# frozen_string_literal: true

class Following < ApplicationRecord
  belongs_to :user
  belongs_to :followed, class_name: 'User'
  validates :user_id, uniqueness: { scope: :followed_id, message: 'Following relation already exists.' }
end
