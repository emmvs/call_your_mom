# Clear the database to prevent duplicate records
User.destroy_all
Contact.destroy_all
Friendship.destroy_all
Interaction.destroy_all
Medium.destroy_all
Note.destroy_all
Reminder.destroy_all
UserSetting.destroy_all

# Users
5.times do |i|
  User.create!(
    email: Faker::Internet.email,
    encrypted_password: Devise::Encryptor.digest(User, 'password'),
    username: "user#{i}",
    password: "123456",
    first_name: Faker::Name.first_name,
    middle_name: Faker::Name.middle_name,
    last_name: Faker::Name.last_name,
    nickname: Faker::Name.first_name,
    emoji: ["☀️", "🌈", "🍿", "🐝", "🎈"].sample
  )
end

users = User.all

# Contacts
users.each do |user|
  5.times do
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

contacts = Contact.all

# Friendships
users.each_with_index do |user, index|
  friend = users.where.not(id: user.id).sample
  Friendship.create!(
    status: [0, 1, 2].sample, # assuming 0: requested, 1: accepted, 2: declined
    requested_at: Time.now,
    responded_at: [nil, Time.now].sample,
    user: user,
    friend_id: friend.id
  )
end

# Media
users.each do |user|
  Medium.create!(
    name: ['Email', 'Phone Call', 'Social Media', 'In Person'].sample,
    user: user
  )
end

# Interactions
contacts.each do |contact|
  Interaction.create!(
    interaction_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    user: contact.user,
    contact: contact,
    medium_id: [1, 2, 3].sample # Assuming these IDs exist in your media table
  )
end

# Notes (assuming they belong to interactions)
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

# User Settings
users.each do |user|
  UserSetting.create!(
    preferred_languages: ['English', 'Spanish', 'French'].sample,
    user: user
  )
end

puts "Seed data created successfully!"
