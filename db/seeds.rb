puts 'Cleaning Database 🧼'

# Clear database
Friendship.destroy_all
User.destroy_all

# Create users
emma = User.create(
  username: 'emmvs',
  email: 'emma@test.com',
  password: '123456',
  first_name: 'Emma', 
  middle_name: 'Anna Agneta',
  last_name: 'Rünzel',
  nickname: 'Emmsi',
  emoji: '☀️'
  )

josh = User.create(
  username: 'xxjmsxx',
  email: 'josh@test.com',
  password: '123456',
  first_name: 'Joshua',
  middle_name: 'Matthew',
  last_name: 'Smith',
  nickname: 'Josh',
  emoji: '🍰'
)

santi = User.create(
  username: "santiagosan93",
  email: "santi@test.com",
  password: "123123",
  first_name: "Santiago",
  middle_name: nil,
  last_name: "Sanchez",
  nickname: "Santi",
  emoji: "🐘"
)

mamma = User.create(
  username: 'kramktomat',
  email: 'sylvia@test.com',
  password: '123456',
  first_name: 'Sylvia',
  middle_name: 'Agneta',
  last_name: 'Rünzel',
  nickname: 'Mamma',
  emoji: '💚'
)

puts "Created #{User.count} Users 🤷🏼‍♂️🧑🏽‍🦱💁🏼‍♀️"

# Creating UserSettings
UserSetting.create(user: emma, preferred_language: 'en')
UserSetting.create(user: josh, preferred_language: 'de')
UserSetting.create(user: santi, preferred_language: 'es')
UserSetting.create(user: mamma, preferred_language: 'sv')

puts "Created #{UserSetting.count} User Settings ☀️"
users = User.find_each

# Emmas Contacts
Contact.create!(
  name: 'Cindy',
  relationship: 'friend',
  email: 'cindyadjei9@gmail.com',
  phone_number: '+49 176 62423222',
  address: 'Wutzkyallee 85, 12353 Berlin',
  social_media_handle: 'afia_agyeman97',
  user: emma
)

Contact.create!(
  name: 'Tinka',
  relationship: 'friend',
  email: 'katinka.stoebbe@gmx.de',
  phone_number: '+49 172 9710096',
  address: 'Lothringer Str 19, 09120 Chemnitz',
  social_media_handle: 'tinka_stoebbe',
  user: emma
)

Contact.create!(
  name: 'Mamma',
  relationship: 'family',
  email: 'sylvia@ruenzel.de',
  phone_number: '+49 175 9633288',
  address: 'Buchenweg 97, 22926 Ahrensburg',
  social_media_handle: 'kramtomat',
  user: emma
)

# Santis Contacts
Contact.create!(
  name: 'Mitchi',
  relationship: 'friend',
  email: 'michelle@lewagon.com',
  phone_number: '+49 172 9710096',
  address: 'Santis house',
  social_media_handle: 'mich_rodd',
  user: santi
  )
  
# Joshs Contacts
Contact.create!(
  name: 'Santi',
  relationship: 'friend',
  email: 'santi@lewagon.com',
  phone_number: '+49 172 9710096',
  address: 'Santis house',
  social_media_handle: 'santiagooo',
  user: josh
)

Contact.create!(
  name: 'Emma',
  relationship: 'friend',
  email: 'emma@ruenzel.de',
  phone_number: '+49 157 85519243',
  address: 'Altenbraker Straße 26, 12051 Berlin, Germany',
  social_media_handle: 'emmvs',
  user: josh
)

Contact.create!(
  name: 'Emma',
  relationship: 'friend',
  email: 'emma@ruenzel.de',
  phone_number: '+49 157 85519243',
  address: 'Altenbraker Straße 26, 12051 Berlin, Germany',
  social_media_handle: 'emmvs',
  user: mamma
)

puts "Created #{Contact.count} Contacts 📇"

# Create friendships
Friendship.create!(
    status: Friendship.statuses[:requested],
    requested_at: Time.current,
    responded_at: [nil, Time.current].sample,
    user: josh,
    friend_id: emma.id
)

Friendship.create!(
    status: Friendship.statuses[:accepted],
    requested_at: Time.current,
    responded_at: [nil, Time.current].sample,
    user: santi,
    friend_id: josh.id
)

Friendship.create!(
    status: Friendship.statuses[:declined],
    requested_at: Time.current,
    responded_at: [nil, Time.current].sample,
    user: emma,
    friend_id: santi.id
)

puts "Created #{Friendship.count} Friendships ♥️"

# Create media
users.each do |user|
  Medium.create!(
    name: Medium::MEDIA_TYPES.sample,
    user:
  )
end

puts "Created #{Medium.count} Media ✉️ ☎️ 🔮"

# Interactions
contacts = Contact.find_each

contacts.each do |contact|
  Interaction.create!(
    interaction_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    user: contact.user,
    contact:,
    medium_id: Medium.all.pluck(:id).sample
  )
end

puts "Created #{Interaction.count} Interactions 📞"

# Notes
Interaction.find_each.each do |interaction|
  Note.create!(
    text: Faker::Lorem.sentence(word_count: 10),
    interaction:
  )
end

puts "Created #{Note.count} Notes 📝"

# Reminders
contacts.each do |contact|
  Reminder.create!(
    frequency_unit: Reminder::FREQUENCY_UNITS.sample,
    frequency_quantity: rand(1..5),
    done: [true, false].sample,
    reminderable: contact,
    user: contact.user
  )
end

puts "Created #{Reminder.count} Reminders 🔔"

puts 'Seed data created successfully! 🌱'
