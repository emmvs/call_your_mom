# Session tests verify the server's handling of user sessions through direct requests,
# while system tests simulate real user interactions with the app's UI & Backend
RSpec.describe "User Sessions with Devise", type: :request do
  let(:user) { FactoryBot.create(:user, password: 'password', password_confirmation: 'password') }

  describe "POST /users/sign_in" do
    context "with valid credentials" do
      it "logs in the user and redirects to the dashboard" do
        post user_session_path, params: { user: { email: user.username, password: 'password' } }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid credentials" do
      it "does not log in the user and re-renders the login form" do
        post user_session_path, params: { user: { email: user.username, password: 'wrong' } }
        expect(response.body).to include('Invalid Username or password')
      end
    end
  end

  describe "DELETE /users/sign_out" do
    it "logs out the user and redirects to the home page" do
      sign_in user
      delete destroy_user_session_path
      expect(response).to redirect_to(root_path)
    end
  end
end
