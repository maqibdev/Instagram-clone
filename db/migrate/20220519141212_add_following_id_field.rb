# frozen_string_literal: true

class AddFollowingIdField < ActiveRecord::Migration[5.2]
  def change
    add_reference :followings, :followed, references: :users, foreign_key: { to_table: :users }
  end
end
