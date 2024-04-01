class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_time_zone
  before_action :set_locale

  def configure_permitted_parameters
    keys = %i[username email first_name middle_name last_name nickname emoji]
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys:)
    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys:)
  end

  private

  # Sets the application's time zone based on the current user's settings. This method is a part of ensuring
  # that the user experience is consistent and personalized across the application. By using the time zone
  # set in the user's profile, all time-related data will reflect the user's local time.
  # https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  def set_time_zone
    # If the user is signed in and has a time zone set, use it
    if user_signed_in? && current_user.user_setting&.time_zone.present?
      # Geocoder sets timezone based on the IP address
      Time.zone = current_user.user_setting.time_zone
    else
      default_time_zone = "UTC"
      # Try to determine the time zone from the request's IP if the user has not set a preference
      Time.zone = request_location_time_zone || default_time_zone
    end
  end

  def request_location_time_zone
    location_data = Geocoder.search(request.remote_ip).first
    location_data&.data&.dig('timezone')
  end

  def set_locale
    preferred_language = current_user&.user_setting&.preferred_language
    I18n.locale = preferred_language || I18n.default_locale
  end
end
