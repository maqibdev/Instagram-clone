# frozen_string_literal: true

class AddIndexToFollowings < ActiveRecord::Migration[5.2]
  def change
    add_index :followings, %i[user_id followed_id], unique: true
  end
end
