# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts, id: :uuid do |t|
      t.uuid :user_id
      t.string :content
      t.timestamps
    end

    add_index :posts, :user_id
  end
end
