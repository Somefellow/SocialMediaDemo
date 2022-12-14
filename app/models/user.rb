# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  email           :string
#  full_name       :string
#  password_digest :string
#  search_field    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  # Password
  include ActiveModel::SecurePassword
  has_secure_password

  # Scopes for views
  scope :by_email, -> { unscope(:order).order(email: :asc) }

  # Posts
  has_many :posts, dependent: :destroy

  # Friendships
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :received_friends, through: :received_friendships, source: 'user'

  def active_friends
    friends.select { |friend| friend.friends.include?(self) }
  end

  def pending_friends
    friends.reject { |friend| friend.friends.include?(self) }
  end

  def pending_friend_requests
    received_friends.reject { |friend| friend.active_friends.include?(self) }
  end

  private

  # Search field
  before_save :populate_search_field

  SEARCHABLE_ATTRIBUTES = %i[email full_name].freeze

  def populate_search_field
    self.search_field = SEARCHABLE_ATTRIBUTES.map { |attr| send(attr).downcase }.join(' ')
  end
end
