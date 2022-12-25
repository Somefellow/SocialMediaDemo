# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  email           :string
#  full_name       :string
#  password_digest :string
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
    assert User.count.positive?
    assert User.where(password_digest: nil).empty?
  end

  test 'password mandatory' do
    assert_raise ActiveRecord::RecordInvalid do
      User.create!(email: 'test@test.com', full_name: 'name')
    end
  end

  test 'email unique' do
    assert_raise ActiveRecord::RecordNotUnique do
      User.create!(email: User.last.email, full_name: 'name', password: 'password')
    end
  end
end
