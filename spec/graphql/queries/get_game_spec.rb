# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GetGame", type: :request do
  let!(:user) { create(:user) }
  let!(:game_1) { create(:game, user: user) }

  let(:gql_query) do
    <<-GRAPHQL
      query ($gameId: ID!) {
        getGame(gameId: $gameId) {
          id
          rows
          cols
          won
          winnedAt
          user {
            id
            email
          }
          board {
            width
            height
            minesCount
            grid {
              rows {
                cells {
                  row
                  col
                  mine
                  revealed
                  flagged
                  neighborsCount
                }
              }
            }
          }
        }
      }
    GRAPHQL
  end

  let(:variables) do
    { gameId: game_1.id }
  end

  let!(:headers) { user_auth_headers(user) }

  context "fetch a user's game" do
    specify do
      graphql_request(gql_query, variables: variables, headers: headers)
      expect_no_graphql_errors

      response = response_body.dig("data", "getGame")

      expect(response["id"]).to eq(game_1.id.to_s)
      expect(response["rows"]).to eq(game_1.rows)
    end
  end
end
