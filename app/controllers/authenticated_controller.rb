# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  before_action :deny_if_not_logged_in

  protected

  def deny_if_not_logged_in
    return if helpers.logged_in?

    flash[:danger] = 'You need to be logged in to access that page.'
    redirect_to root_path
  end
end
