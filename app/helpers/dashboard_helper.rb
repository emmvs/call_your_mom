module DashboardHelper
  def greeting_for_current_user
    greeting = if user_signed_in?
                 "#{t("greetings.#{day_attributes[:time_of_day]}")} #{current_user.nickname} #{day_attributes[:emoji]}"
               else
                 "#{t('greetings.sunshine')} #{emoji}"
               end

    # Avoids potential cross-site scripting (XSS) attacks
    greeting.html_safe
  end

  private

  def day_attributes
    if morning_range.cover?(current_hour)
      { time_of_day: 'morning', emoji: '🌱' }
    elsif afternoon_range.cover?(current_hour)
      { time_of_day: 'day', emoji: '☀️' }
    elsif evening_range.cover?(current_hour)
      { time_of_day: 'evening', emoji: '🌈' }
    else
      { time_of_day: 'night', emoji: '🌙' } # TODO: Implement Moon depending on time of the month @josh
    end
  end

  def current_hour
    # Uses time zone set in ApplicationController
    Time.current.hour
  end

  def morning_range
    0...12
  end

  def afternoon_range
    12...18
  end

  def evening_range
    18...22
  end

  def night_range
    22...24
  end
end
