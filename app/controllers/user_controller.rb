# frozen_string_literal: true

class UserController < AuthenticatedController
  before_action :find_user, only: [:show]
  before_action :can_view_user?, only: [:show]

  def show; end

  private

  def find_user
    @user = if params[:id].present?
              if params[:id] == helpers.current_user.id
                helpers.current_user
              else
                User.find(params[:id])
              end
            else
              helpers.current_user
            end
  end

  def can_view_user?
    @user == helpers.current_user || helpers.current_user.friends.include?(@user)
  end
end
