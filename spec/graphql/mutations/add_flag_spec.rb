# frozen_string_literal: true

require "rails_helper"

RSpec.describe "AddFlag", type: :request do
  include_context "game_with_fixed_board"

  let!(:game) { game_with_fixed_board }
  let!(:cell) { game.board.at(0, 0) }

  let(:gql_query) do
    <<-GRAPHQL
      mutation ($input: AddFlagInput!) {
        addFlag(input: $input)
        {
          cell {
            row
            col
            mine
            flagged
            revealed
            neighborsCount
          }
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

  describe "adds a flag to a board cell" do
    context "when a cell exists" do
      it "flags a cell" do
        graphql_request(gql_query, variables: variables, headers: headers)
        expect_no_graphql_errors

        response = response_body.dig("data", "addFlag")

        expect(response["cell"]["flagged"]).to be_truthy
        expect(response["cell"]["row"]).to eq(cell.row)
        expect(response["cell"]["col"]).to eq(cell.col)

        game_updated = Game.find(game.id)

        expect(game_updated.board.flagged.size).to eq(1)
      end
    end

    context "when a cell does not exists" do
      it "raises error" do
        variables[:input][:row] = -1
        graphql_request(gql_query, variables: variables, headers: headers)

        expect_graphql_error(/Cell does not exist/)
      end
    end
  end
end
