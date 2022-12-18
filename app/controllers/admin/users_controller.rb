# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :load_users

    def index; end

    private

    def load_users
      @users = User.by_email
    end
  end
end
