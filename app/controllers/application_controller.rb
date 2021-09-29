class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index]

  def access_denied(exception)
    redirect_to '/', alert: exception.message
  end
  
  # This method is necessary if we don't want to be redirected to home page after login
  #     (for example if we are redirected from an email)
  def after_sign_in_path_for(resource)
    session["user_return_to"] || root_path
  end
  
end
