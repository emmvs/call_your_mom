RSpec.describe Contact, type: :model do
  let(:user) { create(:user) }

  describe 'associations' do
    it { should belong_to(:user) }
    subject { build(:contact) }
  end

  # Validations
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:relationship) }
    it { should validate_presence_of(:user_id) }

    it { should allow_value('friend', 'family', 'colleague').for(:relationship) }
    it { should_not allow_value('enemy').for(:relationship) }

    it { should allow_value('example@example.com').for(:email) }
    it { should_not allow_value('not-an-email').for(:email) }
  end

  # Attributes
  context 'attribute validations' do
    subject(:contact) do
      build(:contact, 
            name: 'John Doe', 
            email: 'john@example.com', 
            phone_number: '123-456-7890', 
            address: '123 Some St, City', 
            social_media_handle: '@johndoe',
            user: user)
    end

    it 'is valid with valid attributes' do
      expect(contact).to be_valid
    end

    it 'is invalid without a name' do
      contact.name = nil
      expect(contact).not_to be_valid
    end

    it 'is invalid without an email' do
      contact.email = nil
      expect(contact).not_to be_valid
    end

    it 'is invalid without a phone_number' do
      contact.phone_number = nil
      expect(contact).not_to be_valid
    end

    it 'is invalid without an address' do
      contact.address = nil
      expect(contact).not_to be_valid
    end

    it 'is invalid without a social_media_handle' do
      contact.social_media_handle = nil
      expect(contact).not_to be_valid
    end

    it 'is invalid without being associated with a user' do
      contact.user = nil
      expect(contact).not_to be_valid
    end

    it 'is invalid with an incorrect email format' do
      contact.email = 'invalid_email_format'
      expect(contact).not_to be_valid
      expect(contact.errors[:email]).to include('Must be a valid email address 📪')
    end
  end
end

