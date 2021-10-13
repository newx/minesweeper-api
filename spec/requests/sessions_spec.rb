require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let!(:user) { create(:user) }

  let!(:valid_params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  let!(:headers) { { "ACCEPT" => "application/json" } }

  describe "POST /users/sign_in" do
    context "success" do
      it "returns a valid token" do
        post "/users/sign_in", params: valid_params, headers: headers

        expect(response).to have_http_status(:ok)
        expect(response.body["jwt"]).to be_present
      end
    end

    context "authentication failure" do
      let!(:invalid_params) do
        { user: { email: user.email, password: "invalid-password" } }
      end

      it "fails to authenticate with wrong user/password" do
        post "/users/sign_in", params: invalid_params, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST /users/sign_out" do
    context "success" do
      it "signs out the user" do
        post "/users/sign_in", params: valid_params, headers: headers
        expect(response).to have_http_status(:ok)

        response_body = JSON.parse(response.body)
        user_jwt = response_body["jwt"]

        headers.merge!("Authorization" => "Bearer #{user_jwt}")
        delete "/users/sign_out", headers: headers
      end
    end
  end
end
