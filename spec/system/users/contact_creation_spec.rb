# spec/system/contact_creation_spec.rb
require 'rails_helper'

RSpec.describe "Contact creation", type: :system do
  before do
    driven_by(:rack_test) # or :selenium if using a headless browser for JavaScript testing
  end

  it 'displays the form in English' do
    visit new_contact_path(locale: 'en')
    expect(page).to have_content('Add Contact')
    expect(page).to have_button('Save Contact')
  end

  it 'displays the form in German' do
    visit new_contact_path(locale: 'de')
    expect(page).to have_content('Kontakt hinzufügen')
    expect(page).to have_button('Kontakt speichern')
  end
end
