RSpec.describe "Interactions", type: :request do
  let(:user) { create(:user) }
  let(:contact) { create(:contact, user:) }
  let(:medium) { create(:medium, user:) }
  let(:interaction_attributes) do
    attributes_for(:interaction,
                   user_id: user.id,
                   contact_id: contact.id).merge(medium: medium.name)
  end

  before { sign_in user }

  it "handles interaction views and creation" do
    # GET new
    get contact_path(contact)
    expect(response).to have_http_status(:success)

    # GET show/index
    create(:interaction, user:, contact:, medium:)
    get contact_path(contact)
    expect(response).to have_http_status(:success)

    # POST create
    post interactions_path, params: { interaction: interaction_attributes }
    expect(response).to redirect_to(contact_path(contact))
    follow_redirect!
    expect(response).to have_http_status(:success)
  end
end
