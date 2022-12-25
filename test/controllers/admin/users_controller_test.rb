# frozen_string_literal: true

require 'test_helper'

module Admin
  class UsersControllerTest < ActionDispatch::IntegrationTest
    test 'should get users' do
      get admin_users_path
      assert_response :success
    end
  end
end
