RSpec.describe DashboardHelper, type: :helper do
  describe '#time_based_greeting' do
    before do
      allow(helper).to receive(:user_time_zone).and_return('Europe/Berlin')
    end

    it 'returns "Good Morning," before noon in Berlin time zone' do
      travel_to Time.zone.parse('2024-03-20 09:00:00 +0100') do
        expect(helper.time_based_greeting).to eq('Good Morning, ')
      end
    end

    it 'returns "Good Day," between noon and 6pm in Berlin time zone' do
      travel_to Time.zone.parse('2024-03-20 13:00:00 +0100') do
        expect(helper.time_based_greeting).to eq('Good Day, ')
      end
    end

    it 'returns "Good Evening," between 6pm and 10pm in Berlin time zone' do
      travel_to Time.zone.parse('2024-03-20 19:00:00 +0100') do
        expect(helper.time_based_greeting).to eq('Good Evening, ')
      end
    end

    it 'returns "Good Night," after 10pm in Berlin time zone' do
      travel_to Time.zone.parse('2024-03-20 23:00:00 +0100') do
        expect(helper.time_based_greeting).to eq('Good Night, ')
      end
    end
  end

  describe '#time_based_emoji' do
    before do
      allow(helper).to receive(:user_time_zone).and_return("Berlin")
    end
  end

  private

  def user_time_zone
    'Europe/Berlin'
  end
end
