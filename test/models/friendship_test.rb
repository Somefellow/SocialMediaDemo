# frozen_string_literal: true

# == Schema Information
#
# Table name: friendships
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_id  :uuid
#  user_id    :uuid
#
# Indexes
#
#  index_friendships_on_user_id_and_friend_id  (user_id,friend_id) UNIQUE
#
require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
