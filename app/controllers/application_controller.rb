class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_time_zone, if: :user_signed_in?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :first_name, :middle_name, :last_name, :nickname, :emoji])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :first_name, :middle_name, :last_name, :nickname, :emoji])
  end

  private
  
  # Sets the application's time zone based on the current user's settings. This method is a part of ensuring 
  # that the user experience is consistent and personalized across the application. By using the time zone 
  # set in the user's profile, all time-related data will reflect the user's local time.
  # https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  def set_time_zone
    Time.zone = current_user.user_setting.time_zone if current_user.user_setting&.time_zone.present?
  end
end
