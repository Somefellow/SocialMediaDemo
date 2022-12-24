# frozen_string_literal: true

class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :friend_id
      t.timestamps
    end

    add_index :friendships, %i[user_id friend_id], unique: true
  end
end
