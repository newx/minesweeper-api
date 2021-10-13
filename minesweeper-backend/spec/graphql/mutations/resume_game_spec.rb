# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ResumeGame", type: :request do
  include_context "game_with_fixed_board"

  let!(:game) { game_with_fixed_board }

  let(:gql_query) do
    <<-GRAPHQL
      mutation ($input: ResumeGameInput!) {
        resumeGame(input: $input) {
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

  before do
    # Executes a game action
    game.play do |gm|
      gm.board.reveal(0, 0)
    end
  end

  context "resumes a given game" do
    it "restores previous game board state" do
      graphql_request(gql_query, variables: variables, headers: headers)

      response = response_body.dig("data", "resumeGame")

      expect(response["game"]["status"]).to eq("started")

      game.reload
      expect(game.started?).to be_truthy
      expect(game.board.new_board?).to be_falsey
    end
  end
end
