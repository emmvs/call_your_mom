RSpec.describe "Contact creation", type: :system do
  let(:english_user) { FactoryBot.create(:user, user_setting: FactoryBot.create(:user_setting, preferred_language: 'en')) }
  let(:german_user) { FactoryBot.create(:user, user_setting: FactoryBot.create(:user_setting, preferred_language: 'de')) }
  let(:spanish_user) { FactoryBot.create(:user, user_setting: FactoryBot.create(:user_setting, preferred_language: 'es')) }
  let(:swedish_user) { FactoryBot.create(:user, user_setting: FactoryBot.create(:user_setting, preferred_language: 'sv')) }

  before do
    driven_by(:rack_test) # or :selenium if using a headless browser for JavaScript testing
  end

  it 'displays the form in English' do
    login_as(english_user, scope: :user)
    visit new_contact_path
    expect(page).to have_content('Add Contact')
    expect(page).to have_button('Save Contact')
  end

  it 'displays the form in German' do
    login_as(german_user, scope: :user)
    visit new_contact_path
    expect(page).to have_content('Kontakt hinzufügen')
    expect(page).to have_button('Kontakt speichern')
  end

  it 'displays the form in Spanish' do
    login_as(spanish_user, scope: :user)
    visit new_contact_path
    expect(page).to have_content('Añadir contacto')
    expect(page).to have_button('Guardar contacto')
  end

  it 'displays the form in Swedish' do
    login_as(swedish_user, scope: :user)
    visit new_contact_path
    expect(page).to have_content('Lägg till kontakt')
    expect(page).to have_button('Spara kontakt')
  end
end
