require "rails_helper.rb"

RSpec.describe User, type: :model do
  it 'is valid with all required attributes' do
    user = User.new(
      first_name: 'Emma',
      middle_name: 'Anna Agneta',
      last_name: 'Rünzel',
      username: 'emmvs',
      email: 'emma@test.com',
      password: '123456',
    )
    expect(user).to be_valid
  end

  it 'is invalid without a first_name' do
    user = User.new(first_name: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without an email' do
    user = User.new(email: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without a password' do
    user = User.new(password: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid with an incorrect email format' do
    user = User.new(email: 'invalid_email')
    expect(user).not_to be_valid
  end

  it 'has a unique username' do
    User.create(username: "emmvs", first_name: 'Emma', email: 'emma@test.com', password: '123456')
    user = User.new(username: "emmvs", first_name: 'Santi', email: 'santi@test.com', password: '123456')
    expect(user).not_to be_valid
  end
end
