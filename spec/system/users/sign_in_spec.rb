describe "Sign In Process", type: :feature do

  before :each do
    User.create(username: "emmvs", email: 'emma@test.com', password: '123456')
  end

  it "signs me in" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'user_username', with: 'emmvs'
      fill_in 'user_password', with: '123456'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end