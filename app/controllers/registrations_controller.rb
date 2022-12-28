# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def new; end

  def create
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
