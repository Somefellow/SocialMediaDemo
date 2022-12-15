# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :load_users

  def index; end

  private

  def load_users
    @users = User.by_username
  end
end
