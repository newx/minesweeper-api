# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Reveal", type: :request do
  include_context "game_with_fixed_board"

  let!(:game) { game_with_fixed_board }
  let!(:cell) { game.board.at(0, 0) }

  let!(:expected_revealed_cells_coords) do
    [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [0, 8], [0, 9], [1, 0], [1, 6], [1, 7], [1, 8], [1, 9], [2, 8], [2, 9], [3, 8], [3, 9]]
  end

  let(:gql_query) do
    <<-GRAPHQL
      mutation ($input: RevealInput!) {
        reveal(input: $input)
        {
          cell {
            row
            col
            mine
            flagged
            revealed
            neighborsCount
          }
          revealedCells {
            row
            col
            neighborsCount
          }
          win
        }
      }
    GRAPHQL
  end

  let(:variables) do
    {
      input: {
        gameId: game.id,
        row: cell.row,
        col: cell.col
      }
    }
  end

  let!(:headers) { user_auth_headers(user) }

  context "reveals a game board cell" do
    specify do
      graphql_request(gql_query, variables: variables, headers: headers)
      expect_no_graphql_errors

      response = response_body.dig("data", "reveal")

      expect(response["cell"]["revealed"]).to be_truthy
      expect(response["cell"]["row"]).to eq(cell.row)
      expect(response["cell"]["col"]).to eq(cell.col)

      revealed_cells = response["revealedCells"]
      revealed_cells_coords = revealed_cells.map { |item| [item["row"], item["col"]] }.sort

      game_updated = Game.find(game.id)

      expect(revealed_cells.size).to eq(game_updated.board.revealed.size)
      expect(revealed_cells_coords).to eq(expected_revealed_cells_coords)
    end
  end

  describe "when the last board cell is revealed" do
    before do
      cells_list = game.board.non_mines_cells

      game.play do
        # reveal all non-mines cells except the last one
        while cells_list.size > 1
          cell = cells_list.shift
          cell.revealed = true
        end
      end
    end

    let!(:last_non_revealed_cell) { game.board.non_mines_cells.reject(&:revealed?).first }

    it "wins the game" do
      variables[:input][:row] = last_non_revealed_cell.row
      variables[:input][:col] = last_non_revealed_cell.col

      graphql_request(gql_query, variables: variables, headers: headers)
      expect_no_graphql_errors

      response = response_body.dig("data", "reveal")

      expect(response["win"]).to be_truthy
    end
  end
end
