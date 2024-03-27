RSpec.describe Interaction, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:contact) }
    it { is_expected.to belong_to(:medium) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:interaction_date) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:contact_id) }
    it { is_expected.to validate_presence_of(:medium_id) }
  end

  describe '#interaction_date' do
    let(:interaction) { build(:interaction) }

    it 'is valid with a future date' do
      interaction.interaction_date = 1.day.from_now
      expect(interaction).to be_valid
    end

    it 'is valid with a past date' do
      interaction.interaction_date = 1.day.ago
      expect(interaction).to be_valid
    end
  end
end
