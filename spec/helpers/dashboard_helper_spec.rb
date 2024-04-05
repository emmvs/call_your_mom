RSpec.describe DashboardHelper, type: :helper do # rubocop:disable Metrics/BlockLength
  include Devise::Test::ControllerHelpers

  before do
    helper.class_eval do
      def user_time_zone
        'Europe/Berlin'
      end
    end
  
    allow(helper).to receive(:user_signed_in?).and_return(true)
    allow(helper).to receive(:current_user).and_return(double("User", nickname: 'Emma'))
    define_greetings
  end

  shared_examples "time_based_greetings" do |time, expected_greeting|
    context "at #{time}" do
      it "returns '#{expected_greeting}'" do
        travel_to Time.zone.parse(time) do
          expect(helper.greeting_for_current_user).to eq(expected_greeting)
        end
      end
    end
  end

  describe "greeting_for_current_user" do
    it_behaves_like "time_based_greetings", '2024-03-20 09:00:00 +0100', 'Good Morning, Emma 🌱'
    it_behaves_like "time_based_greetings", '2024-03-20 13:00:00 +0100', 'Good Day, Emma ☀️'
    it_behaves_like "time_based_greetings", '2024-03-20 19:00:00 +0100', 'Good Evening, Emma 🌈'
    it_behaves_like "time_based_greetings", '2024-03-20 23:00:00 +0100', 'Good Night, Emma 🌙'
  end

  def define_greetings
    I18n.backend.store_translations(:en, greetings:
    {
      morning: 'Good Morning,',
      day: 'Good Day,',
      evening: 'Good Evening,',
      night: 'Good Night,',
      sunshine: 'Hello Sunshine,'
    })
  end
end
