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
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'password_digest populated' do
    user1 = User.create!(email: 'david_heinemeier_hansson@example.com', full_name: 'David Heinemeier Hansson', password: 'password1')
    assert_respond_to user1, :password_digest
    assert_respond_to user1, :authenticate, 'User requires has_secure_password'
    assert user1.authenticate('password1')

    user2 = User.create!(email: 'steve_ross_kellock@example.com', full_name: 'Steve Ross Kellock', password: 'password2')
    assert_respond_to user2, :password_digest
    assert_respond_to user2, :authenticate, 'User requires has_secure_password'
    assert user2.authenticate('password2')

    User.destroy_all
  end

  test 'password mandatory' do
    assert_raise ActiveRecord::RecordInvalid do
      User.create!(email: 'david_heinemeier_hansson@example.com', full_name: 'David Heinemeier Hansson')
    end
    User.destroy_all
  end

  test 'email unique' do
    user1 = User.create!(email: 'david_heinemeier_hansson@example.com', full_name: 'David Heinemeier Hansson', password: 'password1')
    assert_raise ActiveRecord::RecordNotUnique do
      User.create!(email: user1.email, full_name: user1.full_name, password: 'password1')
    end
    User.destroy_all
  end

  test 'search field populated' do
    user1 = User.create!(email: 'david_heinemeier_hansson@example.com', full_name: 'David Heinemeier Hansson', password: 'password1')
    assert_equal user1.search_field, 'david_heinemeier_hansson@example.com david heinemeier hansson'
    user2 = User.create!(email: 'steve_ross_kellock@example.com', full_name: 'Steve Ross Kellock', password: 'password2')
    assert_equal user2.search_field, 'steve_ross_kellock@example.com steve ross kellock'
    User.destroy_all
  end
end
