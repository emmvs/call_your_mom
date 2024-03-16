class Medium < ApplicationRecord
  MEDIA_TYPES = ['In Person', 'Phone Call', 'Text Message', 'Voice Message', 'Social Media', 'Gaming', 'Email', 'Meme']

  belongs_to :user
end
