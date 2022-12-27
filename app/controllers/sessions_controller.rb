# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      flash[:success] = 'Successful login.'
      session[:user_id] = user.id
      session[:email] = user.email
      session[:full_name] = user.full_name
      redirect_to root_path
    else
      flash[:danger] = 'Invalid email/password combination.'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
