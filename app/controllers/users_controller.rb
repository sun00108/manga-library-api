class UsersController < ApplicationController

  def fetch_profile
    user = current_user
    render json: { code: 0, message: '', data: user }
  end

end
