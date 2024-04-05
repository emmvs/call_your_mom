module ContactsHelper
  def display_contact_attribute(label, value)
    return if should_skip_attribute?(label, value)

    formatted_value = format_value_by_label(label, value)
    content_tag(:h4, formatted_value)
  end

  private

  def should_skip_attribute?(label, value)
    blank_value?(value) || skip_based_on_label_and_value?(label, value)
  end

  def blank_value?(value)
    value.blank?
  end

  def skip_based_on_label_and_value?(label, value)
    (label == 'relationship' && value == "friend") ||
      (label == 'social_media_handle' && value == "@ig_name")
  end

  def format_value_by_label(label, value)
    label == 'social_media_handle' ? format_social_media_handle(value) : value
  end

  def format_social_media_handle(handle)
    handle.start_with?('@') ? handle : "@#{handle}"
  end
end
