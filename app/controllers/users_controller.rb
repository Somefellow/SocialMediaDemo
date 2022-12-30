# frozen_string_literal: true

class UsersController < ApplicationController
  def show; end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
