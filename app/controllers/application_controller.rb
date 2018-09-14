class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    request.env['warden'].user
  end
end
