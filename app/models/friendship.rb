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
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates_presence_of :user_id, :friend_id
  validate :user_is_not_equal_friend
  validates_uniqueness_of :user_id, scope: [:friend_id]

  def mutual?
    friend.friends.include?(user)
  end

  def since
    raise RuntimeError 'Cannot get start of friendship unless users are mutual friends.' unless mutual?

    [created_at, inverse_friendship.created_at].max
  end

  private

  def user_is_not_equal_friend
    errors.add(:friend, "can't be the same as the user") if user == friend
  end

  def inverse_friendship
    raise RuntimeError 'Cannot get inverse of friendship unless users are mutual friends.' unless mutual?

    @inverse_friendship ||= Friendship.find_by(user_id: friend_id, friend_id: user_id)
  end
end
