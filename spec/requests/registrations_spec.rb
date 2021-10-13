require "rails_helper"

RSpec.describe "Registrations", type: :request do
  let!(:user) { create(:user) }

  let!(:email) { "user@example.com" }
  let!(:password) { "12345678" }

  let!(:valid_params) do
    {
      user: {
        email: email,
        password: password
      }
    }
  end

  let!(:headers) { { "ACCEPT" => "application/json" } }

  describe "POST /users" do
    context "success" do
      it "creates a new user" do
        post "/users", params: valid_params, headers: headers

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
