RSpec.feature "Authentication & Sign In Process", type: :feature do
  let(:password) { "123123" }
  let(:user) { create(:user) }

  context "👨🏻‍💻 Users that are not logged in" do
    scenario "are directed to the home page" do
      # Preparation
      visit root_path

      # Assertion
      expect(page).to have_content('Welcome home!!!')
    end
  end
  
  context "👩🏼‍💻 Users that are trying to log in" do
    before(:each) do
      visit new_user_session_path

      fill_in 'user_username', with: user.username
      fill_in 'user_password', with: password
      click_button 'Log in'
    end
  
    context "when the user password is right" do
      scenario "are redirected to the dashboard" do
        visit root_path

        expect(page).to have_content('Hello')
      end
    
      scenario "see a success alert" do
        expect(page).to have_content 'Signed in successfully.'
      end
    end
  
    context "when the password is wrong" do
      let(:password) { "lalalalalalalla" }

      scenario "are not able to sign in" do
        expect(page).to have_content 'Invalid Username or password.'
      end
    end
  end
end
