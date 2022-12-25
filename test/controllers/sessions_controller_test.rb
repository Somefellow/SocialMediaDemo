# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get login' do
    get login_path
    assert_response :success
  end

  test 'should save the user id to session on successful login' do
    post login_path, params: { session: { email: users(:user1).email, password: 'password1' } }
    follow_redirect!
    assert_equal session[:user_id], users(:user1).id
  end

  test 'should not save the email to session on failed login' do
    post login_path, params: { session: { email: users(:user2).email, password: 'password1' } }
    assert_nil session[:user_id]
  end

  test 'should forward to root on successful login' do
    post login_path, params: { session: { email: users(:user2).email, password: 'password2' } }
    follow_redirect!
    assert_equal path, root_path
  end

  test 'should stay on login page on failed login' do
    post login_path, params: { session: { email: users(:user1).email, password: 'password2' } }
    assert_equal path, login_path
    assert_equal flash[:danger], 'Invalid email/password combination'
  end
end
