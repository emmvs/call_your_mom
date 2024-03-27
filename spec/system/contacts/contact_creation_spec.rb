RSpec.describe "Contact creation", type: :system do
  before do
    driven_by(:rack_test)
  end

  [
    { user: 'english_user', content: 'Add Contact', button: 'Save Contact' },
    { user: 'german_user', content: 'Kontakt hinzufügen', button: 'Kontakt speichern' },
    { user: 'spanish_user', content: 'Añadir contacto', button: 'Guardar contacto' },
    { user: 'swedish_user', content: 'Lägg till kontakt', button: 'Spara kontakt' }
  ].each do |example|
    it "displays the form in #{example[:user]}'s preferred language" do
      user = send(example[:user])
      login_as(user, scope: :user)
      visit new_contact_path

      expect(page).to have_content(example[:content])
      expect(page).to have_button(example[:button])
    end
  end

  def user_setting_with_preferred_language(preferred_language)
    FactoryBot.create(:user_setting, preferred_language:)
  end

  let(:english_user) { FactoryBot.create(:user, user_setting: user_setting_with_preferred_language('en')) }
  let(:german_user) { FactoryBot.create(:user, user_setting: user_setting_with_preferred_language('de')) }
  let(:spanish_user) { FactoryBot.create(:user, user_setting: user_setting_with_preferred_language('es')) }
  let(:swedish_user) { FactoryBot.create(:user, user_setting: user_setting_with_preferred_language('sv')) }
end
