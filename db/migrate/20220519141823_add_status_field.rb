# frozen_string_literal: true

class AddStatusField < ActiveRecord::Migration[5.2]
  def change
    add_column :followings, :status, :boolean, default: false
  end
end
