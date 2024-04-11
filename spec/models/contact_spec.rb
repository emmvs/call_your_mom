RSpec.describe Contact, type: :model do
  subject(:contact) { build(:contact) }

  describe 'associations' do
    it { is_expected.to belong_to(:user).required(true) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:relationship) }
    it { is_expected.to allow_value('example@example.com').for(:email) }
    it { is_expected.to allow_value('friend', 'family', 'colleague', 'enemy').for(:relationship) }
    it { is_expected.not_to allow_value('idiot').for(:relationship) }
  end
end
