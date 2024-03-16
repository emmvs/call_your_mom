RSpec.feature "Contacts Routing", type: :feature do
  let(:user) { create(:user) }
  let!(:contact) { create(:contact, user: user) }

  context "👨🏻‍💻 Unauthenticated users" do
    scenario "cannot access contacts index" do
      visit contacts_path
      expect(current_path).to eq(new_user_session_path)
    end

    scenario "cannot access new contact page" do
      visit new_contact_path
      expect(current_path).to eq(new_user_session_path)
    end

    scenario "cannot access a contact's show page" do
      visit contact_path(contact)
      expect(current_path).to eq(new_user_session_path)
    end
  end

  context "👩🏼‍💻 Authenticated users" do
    before do
      login_as(user, scope: :user)
    end

    scenario "can access contacts index" do
      visit contacts_path
      expect(current_path).to eq(contacts_path)
      expect(page).to have_content('Contacts 📇')
    end

    scenario "can access new contact page" do
      visit new_contact_path
      expect(current_path).to eq(new_contact_path)
      expect(page).to have_content('Name of Your Person')
    end

    scenario "can access a contact's show page" do
      visit contact_path(contact)
      expect(current_path).to eq(contact_path(contact))
      expect(page).to have_content(contact.name)
    end
  end
end
