RSpec.describe "Contacts", type: :request do
  let(:user) { create(:user) }
  let(:contact) { create(:contact, user:) }
  let(:contact_attributes) { attributes_for(:contact, user_id: user.id) }

  before { sign_in user }

  it "handles contact views and creation" do
    # GET new
    get new_contact_path
    expect(response).to have_http_status(:success)

    # GET show
    get contact_path(contact)
    expect(response).to have_http_status(:success)

    # GET index
    get contacts_path
    expect(response).to have_http_status(:success)

    # POST create
    post contacts_path, params: { contact: contact_attributes }
    expect(response).to redirect_to(contacts_path)
    follow_redirect!
    expect(response.body).to include("Contacts")
  end
end
