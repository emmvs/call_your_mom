module DashboardHelper
  def greeting_for_current_user
    if user_signed_in?
      "#{time_based_greeting}#{current_user.nickname} #{time_based_emoji}"
    else
      "#{t('greetings.sunshine')}#{time_based_emoji}"
    end
  end

  def time_based_greeting
    time_of_day = case Time.current.in_time_zone(user_time_zone).hour
                  when 0...12 then 'morning'
                  when 12...18 then 'day'
                  when 18...22 then 'evening'
                  else 'night'
                  end
    t("greetings.#{time_of_day}")
  end

  def time_based_emoji
    case Time.current.in_time_zone(user_time_zone).hour
    when 0...12 then '🌱'
    when 12...18 then '☀️'
    when 18...22 then '🌈'
    else '🌙'
    end
  end

  private

  def user_time_zone
    current_user.user_setting&.time_zone || 'Europe/Berlin'
  end
end
