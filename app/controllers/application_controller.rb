require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Make sure users are authenticated before any action unless explicitly stated otherwise
  before_action :authenticate_user!

  # Add this to ensure Devise accepts custom parameters (like username)
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Allow custom fields like :username in the Devise forms
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
