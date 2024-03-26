RSpec.describe Contact, type: :model do
  subject(:contact) { build(:contact) }

  describe 'associations and validations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:relationship) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to allow_value('example@example.com').for(:email) }
    it { is_expected.not_to allow_value('not-an-email').for(:email) }
    it { is_expected.to allow_value('friend', 'family', 'colleague', 'enemy').for(:relationship) }
    it { is_expected.not_to allow_value('idiot').for(:relationship) }
  end

  describe 'custom validations' do
    context 'with invalid email format' do
      before { contact.email = 'invalid_email_format' }
      it 'is invalid and has an appropriate error message' do
        expect(contact).not_to be_valid
        expect(contact.errors[:email]).to include('Must be a valid email address 📪')
      end
    end
  end
end
