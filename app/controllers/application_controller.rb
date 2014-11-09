class ApplicationController < ActionController::API

  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  # These modules are required to work with devise token auth
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :band_name
    end

end
