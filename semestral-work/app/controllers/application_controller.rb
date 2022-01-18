class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :display_name, :description, :image])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :display_name, :description, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :display_name, :description, :image])
  end
end
