# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get login' do
    get login_path
    assert_response :success
  end

  test 'should save the user id to session on successful login' do
    user1 = User.create!(email: 'david_heinemeier_hansson@example.com', full_name: 'David Heinemeier Hansson', password: 'password1')
    post login_path, params: { session: { email: user1.email, password: 'password1' } }
    follow_redirect!
    assert_equal session[:user_id], user1.id
    User.destroy_all
  end

  test 'should not save the email to session on failed login' do
    user1 = User.create!(email: 'david_heinemeier_hansson@example.com', full_name: 'David Heinemeier Hansson', password: 'password1')
    post login_path, params: { session: { email: user1.email, password: 'wrong_password' } }
    assert_nil session[:user_id]
    User.destroy_all
  end

  test 'should forward to root on successful login' do
    user1 = User.create!(email: 'david_heinemeier_hansson@example.com', full_name: 'David Heinemeier Hansson', password: 'password1')
    post login_path, params: { session: { email: user1.email, password: 'password1' } }
    follow_redirect!
    assert_equal path, root_path
    User.destroy_all
  end

  test 'should stay on login page on failed login' do
    user1 = User.create!(email: 'david_heinemeier_hansson@example.com', full_name: 'David Heinemeier Hansson', password: 'password1')
    post login_path, params: { session: { email: user1.email, password: 'wrong_password' } }
    assert_equal path, login_path
    assert_equal flash[:danger], 'Invalid email/password combination.'
    User.destroy_all
  end
end
