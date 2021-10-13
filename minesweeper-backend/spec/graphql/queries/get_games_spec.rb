# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GetGames", type: :request do
  let!(:user) { create(:user) }
  let!(:game_1) { create(:game, user: user) }
  let!(:game_2) { create(:game, user: user) }

  let(:gql_query) do
    <<-GRAPHQL
      query {
        getGames
        {
          id
          rows
          cols
          status
          won
          winnedAt
          user {
            id
            email
          }
        }
      }
    GRAPHQL
  end

  let(:variables) do
    {}
  end

  let!(:headers) { user_auth_headers(user) }

  context "fetches user games" do
    specify do
      graphql_request(gql_query, headers: headers)
      expect_no_graphql_errors

      response = response_body.dig("data", "getGames")

      expect(response.pluck("id")).to include(game_1.id.to_s)
      expect(response.pluck("id")).to include(game_2.id.to_s)
    end
  end
end
