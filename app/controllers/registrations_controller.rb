# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def new; end

  def create
    flash[:danger] = 'Email address required.' unless params[:registration][:email].present?
    flash[:danger] = 'Full name required.' unless params[:registration][:full_name].present?
    flash[:danger] = 'Password required.' unless params[:registration][:password].present?
    render :new && return unless params[:registration][:email].present? &&
                                 params[:registration][:full_name].present? &&
                                 params[:registration][:password].present?

    user = User.create(email: params[:registration][:email],
                       full_name: params[:registration][:full_name],
                       password: params[:registration][:password])

    if user
      flash[:success] = 'Successful registration. You may now login.'
      redirect_to root_path
    else
      flash[:danger] = 'Email address already registered.'
      render :new
    end
  end
end
