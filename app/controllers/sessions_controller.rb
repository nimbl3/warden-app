class SessionsController < ApplicationController
  def new
    redirect_to root_url, alert: request.env['warden'].message
  end

  def create
    request.env['warden'].authenticate!
    redirect_to root_url, notice: 'Logged in!'
  end

  def destroy
    request.env['warden'].logout
    redirect_to root_url, notice: 'Logged out!'
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
