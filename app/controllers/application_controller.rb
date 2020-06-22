class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:first_name,:first_name_furigana,:last_name,:last_name_furigana,:birthday,:postal_code,:city,:building_name,:tel_number,:other,:city,:postal_code,:building_name,:prefecture_id])
  end
end
