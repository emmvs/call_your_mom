puts "Cleaning Database 🧼"
sleep 1
print " ."
sleep 1
print " ."
sleep 1
puts " ."
sleep 1
puts ""

# Clear database to prevent duplicate records
Note.destroy_all
Interaction.destroy_all
Contact.destroy_all
Friendship.destroy_all
Medium.destroy_all
Reminder.destroy_all
UserSetting.destroy_all
User.destroy_all

# Users
emma = User.create(
  username: "emmvs", 
  email: "emma@test.com", 
  password: "123456", 
  first_name: "Emma", 
  middle_name: "Anna Agneta", 
  last_name: "Rünzel",
  nickname: "Emmsi",
  emoji: "☀️"
)

josh = User.create(
  username: "xxjmsxx", 
  email: "josh@test.com", 
  password: "123456", 
  first_name: "Joshua", 
  middle_name: nil, 
  last_name: "Smith",
  nickname: "Josh",
  emoji: "🍰"
)

santi = User.create(
  username: "santiagosan93", 
  email: "santi@test.com", 
  password: "123456", 
  first_name: "Santiago", 
  middle_name: nil, 
  last_name: "Sanchez",
  nickname: "Santi",
  emoji: "🐘"
)

users = User.all

# Contacts
users.each do |user|
  2.times do
    Contact.create!(
      name: Faker::Name.name,
      relationship: ['friend', 'family', 'colleague'].sample,
      email: Faker::Internet.email,
      phone_number: Faker::PhoneNumber.cell_phone,
      address: Faker::Address.full_address,
      social_media_handle: "@#{Faker::Internet.username}",
      user: user
    )
  end
end

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
  name: 'Mamma',
  relationship: 'family',
  email: 'sylvia@ruenzel.de',
  phone_number: '+49 175 9633288',
  address: 'Buchenweg 97, 22926 Ahrensburg',
  social_media_handle: 'kramtomat',
  user: emma
)

contacts = Contact.all

# Friendships
Friendship.create!(
    status: 0, # assuming 0: requested, 1: accepted, 2: declined
    requested_at: Time.now,
    responded_at: [nil, Time.now].sample,
    user: josh,
    friend_id: emma.id
)

Friendship.create!(
    status: 1, # assuming 0: requested, 1: accepted, 2: declined
    requested_at: Time.now,
    responded_at: [nil, Time.now].sample,
    user: santi,
    friend_id: josh.id
)

Friendship.create!(
    status: 2, # assuming 0: requested, 1: accepted, 2: declined (for testing!! ♥️)
    requested_at: Time.now,
    responded_at: [nil, Time.now].sample,
    user: emma,
    friend_id: santi.id
)

# Media
users.each do |user|
  Medium.create!(
    name: ['Email', 'Phone Call', 'Social Media', 'In Person', 'Meme', 'Voice Message'].sample,
    user: user
  )
end

# Interactions
contacts.each do |contact|
  Interaction.create!(
    interaction_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    user: contact.user,
    contact: contact,
    medium_id: Medium.last.id
  )
end

# Notes
Interaction.all.each do |interaction|
  Note.create!(
    text: Faker::Lorem.sentence(word_count: 10),
    interaction: interaction
  )
end

# Reminders
contacts.each do |contact|
  Reminder.create!(
    frequency_unit: ['days', 'weeks', 'months'].sample,
    frequency_quantity: [1, 2, 3, 4, 5].sample,
    done: [true, false].sample,
    reminderable: contact,
    user: contact.user
  )
end

# User Settings w/ ISO 639-1 Language Codes
users.each do |user|
  UserSetting.create!(
    preferred_languages: ['en', 'es', 'fr', 'de', 'sv', 'mt', 'ar'].sample,
    user: user
  )
end

puts "Created #{User.count} Users 🤷🏼‍♂️🧑🏽‍🦱💁🏼‍♀️"
puts "Created #{Contact.count} Contacts 📇"
puts "Created #{Reminder.count} Reminders 🔔"
puts "Created #{Interaction.count} Interactions 📞"
puts "Created #{Note.count} Notes 📝"
puts "Created #{Medium.count} Mediums ✉️ ☎️ 🔮"
puts "Created #{Friendship.count} Friendships ♥️"
puts "Seed data created successfully! 🌱"
