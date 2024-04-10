RSpec.describe "Interaction creation via modal on contact show", type: :system do # rubocop:disable Metrics/BlockLength
  before do
    driven_by(:rack_test)
  end

  let!(:english_user) { create_user_with_settings('en') }
  let!(:german_user) { create_user_with_settings('de') }
  let!(:spanish_user) { create_user_with_settings('es') }
  let!(:swedish_user) { create_user_with_settings('sv') }

  # Helper method to create a user along with user settings
  def create_user_with_settings(language)
    user = create(:user)
    create(:user_setting, user:, preferred_language: language)
    user
  end

  [
    { user_method: :english_user, content: 'Add Interaction', button: 'Save Interaction' },
    { user_method: :german_user, content: 'Interaktion hinzufügen', button: 'Interaktion speichern' },
    { user_method: :spanish_user, content: 'Añadir interacción', button: 'Guardar interacción' },
    { user_method: :swedish_user, content: 'Lägg till interaktion', button: 'Spara interaktion' }
  ].each do |example|
    it "allows #{example[:user_method]} to create an interaction from the contact show page" do
      user = send(example[:user_method])
      contact = create(:contact, user:)
      medium = create(:medium, user:)

      login_as(user, scope: :user)
      visit contact_path(contact)

      find("[data-action='click->modal#open']").click

      expect(page).to have_content(example[:content])
      expect(page).to have_button(example[:button])

      select(medium.name, from: 'Medium')
      fill_in 'interaction[interaction_date]', with: Date.today.strftime('%Y-%m-%d')
      click_button example[:button]

      expect(page).to have_content('Interaction was successfully created.')
    end
  end
end
