RSpec.feature "Authentication & Sign In Process", type: :feature do
  let(:user) { create(:user) }

  scenario "Users not logged in are directed to the home page" do
    visit root_path
    expect(page).to have_content('Welcome home!!!')
  end

  feature "Logging in" do
    scenario "Successfully logs in with correct password" do
      log_in_as(user, '123123')
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_content('Home')
    end

    scenario "Fails to log in with incorrect password" do
      log_in_as(user, 'wrongpassword')
      expect(page).to have_content 'Invalid Username or password.'
    end
  end

  def log_in_as(user, password)
    visit new_user_session_path
    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: password
    click_button 'Log in'
  end
end
