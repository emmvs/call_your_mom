RSpec.feature "Contacts Routing", type: :feature do
  let!(:user) { create(:user) }
  let!(:contact) { create(:contact, user:) }

  scenario "Unauthenticated users are redirected to login" do
    verify_redirection(contacts_path)
    verify_redirection(new_contact_path)
    verify_redirection(contact_path(contact))
  end

  scenario "Authenticated users can access contacts pages" do
    login_as(user, scope: :user)

    verify_access(contacts_path, 'Contacts 📇')
    verify_access(new_contact_path, 'Name of Your Person')
    verify_access(contact_path(contact), contact.name)
  end

  def verify_redirection(path)
    visit path
    expect(current_path).to eq(new_user_session_path)
  end

  def verify_access(path, content)
    puts current_url
    visit path
    expect(current_path).to eq(path)
    expect(page).to have_content(content)
  end
end
