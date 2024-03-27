RSpec.describe Medium, type: :model do
  subject(:medium) { build(:medium) }

  describe 'associations' do
    it 'is expected to belong to user' do
      expect(medium).to belong_to(:user).required(true)
    end
  end

  describe 'validations' do
    it 'is expected to validate that :name cannot be empty/falsy' do
      expect(medium).to validate_presence_of(:name)
    end

    it 'is expected to validate that :user_id cannot be empty/falsy' do
      expect(medium).to validate_presence_of(:user_id)
    end
  end
end
