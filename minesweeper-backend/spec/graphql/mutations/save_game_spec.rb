# frozen_string_literal: true

require "rails_helper"

RSpec.describe "SaveGame", type: :request do
  let!(:user) { create(:user) }
  let!(:game) { create(:game, user: user) }

  let(:gql_query) do
    <<-GRAPHQL
      mutation ($input: SaveGameInput!) {
        saveGame(input: $input) {
          game {
            rows
            cols
            mines
            status
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
      }
    GRAPHQL
  end

  let(:variables) do
    {
      input: {
        gameId: game.id
      }
    }
  end

  let!(:headers) { user_auth_headers(user) }

  context "saves a given game" do
    specify do
      graphql_request(gql_query, variables: variables, headers: headers)

      response = response_body.dig("data", "saveGame")

      pp response
      expect(response["game"]["status"]).to eq("paused")

      game.reload
      expect(game.paused?).to be_truthy
    end
  end
end
