# frozen_string_literal: true

require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get registration' do
    get register_path
    assert_response :success
  end

  test 'should create the user on registration' do
    post register_path, params: { registration: { email: 'david_heinemeier_hansson@example.com', full_name: 'David Heinemeier Hansson', password: 'password1' } }
    assert User.find_by(email: 'david_heinemeier_hansson@example.com').present?
    User.destroy_all
  end

  test 'should direct to home page on registration' do
    post register_path, params: { registration: { email: 'david_heinemeier_hansson@example.com', full_name: 'David Heinemeier Hansson', password: 'password1' } }
    follow_redirect!
    assert_equal flash[:success], 'Successful registration. You may now login.'
    assert_equal path, root_path
    User.destroy_all
  end

  test 'should require an email on register' do
    user_count = User.count
    post register_path, params: { registration: { full_name: 'David Heinemeier Hansson', password: 'password1' } }
    assert_equal flash[:danger], 'Email address required.'
    assert_equal user_count, User.count
  end

  test 'should require full name on register' do
    user_count = User.count
    post register_path, params: { registration: { email: 'david_heinemeier_hansson@example.com', password: 'password1' } }
    assert_equal flash[:danger], 'Full name required.'
    assert_equal user_count, User.count
  end

  test 'should require a password on register' do
    user_count = User.count
    post register_path, params: { registration: { email: 'david_heinemeier_hansson@example.com', full_name: 'David Heinemeier Hansson' } }
    assert_equal flash[:danger], 'Password required.'
    assert_equal user_count, User.count
  end
end
