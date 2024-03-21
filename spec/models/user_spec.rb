RSpec.describe User, type: :model do
  it 'is valid with all required attributes' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without a first_name' do
    user = build(:user, first_name: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without an email' do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid without a password' do
    user = build(:user, password: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid with an incorrect email format' do
    user = build(:user, email: 'invalid_email')
    expect(user).not_to be_valid
  end

  it 'has a unique username' do
    create(:user, username: "unique_username")
    user = build(:user, username: "unique_username")
    expect(user).not_to be_valid
  end
end
