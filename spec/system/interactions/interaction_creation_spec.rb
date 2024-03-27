RSpec.describe "Interaction creation", type: :system do
  before do
    driven_by(:rack_test)
  end

  [
    { user: 'english_user', content: 'Add Interaction', button: 'Save Interaction' },
    { user: 'german_user', content: 'Interaktion hinzufügen', button: 'Interaktion speichern' },
    { user: 'spanish_user', content: 'Añadir interacción', button: 'Guardar interacción' },
    { user: 'swedish_user', content: 'Lägg till interaktion', button: 'Spara interaktion' }
  ].each do |example|
    it "displays the form in #{example[:user]}'s preferred language" do
      user = send(example[:user])
      contact = FactoryBot.create(:contact, user:)
      medium = FactoryBot.create(:medium, user:)

      login_as(user, scope: :user)
      visit new_interaction_path

      expect(page).to have_content(example[:content])
      expect(page).to have_button(example[:button])

      select(contact.name, from: 'Contact')
      select(medium.name, from: 'Medium')
      fill_in 'Interaction date', with: Date.today
      click_button example[:button]

      expect(page).to have_content('Interaction was successfully created.')
    end
  end
end
