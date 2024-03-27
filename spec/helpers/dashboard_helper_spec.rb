RSpec.describe DashboardHelper, type: :helper do
  before do
    allow(helper).to receive(:user_time_zone).and_return('Europe/Berlin')
  end

  [
    ['2024-03-20 09:00:00 +0100', 'Good Morning, ', '🌱'],
    ['2024-03-20 13:00:00 +0100', 'Good Day, ', '☀️'],
    ['2024-03-20 19:00:00 +0100', 'Good Evening, ', '🌈'],
    ['2024-03-20 23:00:00 +0100', 'Good Night, ', '🌙']
  ].each do |time, greeting, emoji|
    context "at #{time}" do
      it "returns correct greeting + #{emoji}" do
        travel_to Time.zone.parse(time) do
          expect(helper.time_based_greeting).to eq(greeting)
          expect(helper.time_based_emoji).to eq(emoji)
        end
      end
    end
  end
end
