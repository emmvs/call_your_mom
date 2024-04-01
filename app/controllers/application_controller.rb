class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_time_zone
  before_action :set_locale

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: User::PERMITTED_PARAMS)
    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: User::PERMITTED_PARAMS)
  end

  private

  def set_time_zone
    # https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
    Time.zone = determine_timezone
  end

  def determine_timezone
    if user_has_preferred_timezone?
      current_user_settings.time_zone
    else
      request_location_time_zone || DEFAULT_TIME_ZONE
    end
  end

  def user_has_preferred_timezone?
    user_signed_in? && current_user_settings&.time_zone.present?
  end

  def request_location_time_zone
    # NOTE: We take the first result as it typically considered the most relevant or accurate for the given IP address
    geocoder_result = Geocoder.search(request.remote_ip).first
    geocoder_result&.data&.dig('timezone')
  end

  def set_locale
    I18n.locale = current_user_settings&.preferred_language || I18n.default_locale
  end

  def current_user_settings
    current_user&.user_setting
  end
end
