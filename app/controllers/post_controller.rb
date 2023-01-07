# frozen_string_literal: true

class PostController < AuthenticatedController
  def create
    helpers.current_user.posts.create(content: params[:post][:content])
    flash[:success] = 'Successfully created a new post.'
    redirect_to URI(request.referer).path
  end
end
