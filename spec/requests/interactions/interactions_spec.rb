RSpec.describe "Interactions", type: :request do
  let(:user) { create(:user) }
  let(:contact) { create(:contact, user:) }
  let(:medium) { create(:medium, user:) }
  let(:interaction_attributes) do
    attributes_for(:interaction,
                   user_id: user.id,
                   contact_id: contact.id,
                   medium_id: medium.id)
  end

  before { sign_in user }

  it "handles interaction views and creation" do
    # GET new
    get new_interaction_path
    expect(response).to have_http_status(:success)

    # GET show
    interaction = create(:interaction, user:, contact:, medium:)
    get interaction_path(interaction)
    expect(response).to have_http_status(:success)

    # GET index
    get interactions_path
    expect(response).to have_http_status(:success)

    # POST create
    post interactions_path, params: { interaction: interaction_attributes }
    expect(response).to redirect_to(interactions_path)
    follow_redirect!
    expect(response.body).to include("Interactions")
  end
end
