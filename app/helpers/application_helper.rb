# frozen_string_literal: true

module ApplicationHelper
  def logged_in?
    session[:user_id].present?
  end

  def current_user_email
    session[:email]
  end

  def current_user_full_name
    session[:full_name]
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end
end
