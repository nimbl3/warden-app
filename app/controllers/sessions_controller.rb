class SessionsController < ApplicationController
  def index
  end

  def create
    request.env['warden'].authenticate!
    redirect_to root_url, notice: 'Logged in!'
  end

  def destroy
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
