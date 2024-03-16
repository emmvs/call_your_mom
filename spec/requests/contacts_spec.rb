RSpec.describe "Contacts", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user, scope: :user)
  end

  describe "GET /contacts" do
    it "returns http success" do
      sign_in user
      get "/contacts"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /contacts" do
    it "creates a new contact and redirects" do
      sign_in user
      post "/contacts", params: { contact: { name: "John Doe", email: "john@example.com", phone_number: "123-456-7890", address: "123 Main St", social_media_handle: "@johndoe" } }
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to include("Contacts")
    end
  end
end
