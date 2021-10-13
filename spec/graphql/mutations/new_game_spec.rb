# frozen_string_literal: true

require "rails_helper"

RSpec.describe "NewGame", type: :request do
  let!(:user) { create(:user) }

  let(:gql_query) do
    <<-GRAPHQL
      mutation ($input: NewGameInput!) {
        newGame(input: $input) {
          game {
            rows
            cols
            mines
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
        level: "beginner"
      }
    }
  end

  let!(:headers) { user_auth_headers(user) }

  context "creates a new game game" do
    specify do
      graphql_request(gql_query, variables: variables, headers: headers)
      expect_no_graphql_errors

      response = response_body.dig("data", "newGame")

      expect(response["game"]["rows"]).to eq(Game::LEVELS[:beginner][:rows])
      expect(response["game"]["cols"]).to eq(Game::LEVELS[:beginner][:cols])
      expect(response["game"]["mines"]).to eq(Game::LEVELS[:beginner][:mines])

      game = Game.by_user(user).last

      expect(game.board.new_board?).to be_truthy
    end
  end
end
