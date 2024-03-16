class Medium < ApplicationRecord
  MEDIA_TYPES = ['Email', 'Phone Call', 'Social Media', 'In Person', 'Meme', 'Voice Message']

  belongs_to :user
end
