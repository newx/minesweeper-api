require 'rails_helper'

RSpec.describe Cell, type: :model do
  let!(:board) { Board.new }

  subject { board.at(5, 5) }

  describe "#to_s" do
    context "when revealed" do
      before { subject.revealed = true }

      it "returns mine value when the cell has a mine" do
        subject.mine = true
        expect(subject.to_s).to eq("x")
      end

      it "returns empty value when cell has no mine" do
        subject.mine = false
        expect(subject.to_s).to eq(subject.neighbors_count_to_s)
      end
    end

    context "when not revealed" do
      before { subject.revealed = false }

      it "hides cell value" do
        subject.mine = true
        expect(subject.to_s).to eq("*")
      end

      it "returns flag value when cell is flagged" do
        subject.flagged = true
        expect(subject.to_s).to eq("F")
      end
    end
  end

  describe "#neighbor_mines_count" do
    include_context "board_with_fixed_mines"

    it "returns the expected neighbors_count values" do
      puts board.to_table(force_reveal: true)

      rendered_grid = board.to_a(force_reveal: true)

      rendered_grid.each_with_index do |row, row_index|
        row.each_with_index do |cell_value, col_index|
          cell = board.at(row_index, col_index)
          cell.revealed = true

          expect(cell.neighbors_count_to_s).to eq(cell_value) unless cell.mine?
        end
      end
    end
  end

  describe "#reveal" do
    include_context "board_with_fixed_mines"

    it "recursively reveal neighbors cells with no neighbors mines" do
      puts board.to_table

      cell = board.at(0, 0)
      cell.reveal

      puts board.to_table
      puts board.to_a.inspect

      expect(board.grid[0].map(&:to_s)).to eq([" ", " ", " ", " ", " ", " ", " ", " ", " ", " "])
      expect(board.grid[1].map(&:to_s)).to eq([" ", "*", "*", "*", "*", "*", " ", " ", " ", " "])
      expect(board.grid[2].map(&:to_s)).to eq(["*", "*", "*", "*", "*", "*", "*", "*", " ", " "])
      expect(board.grid[3].map(&:to_s)).to eq(["*", "*", "*", "*", "*", "*", "*", "*", " ", " "])
    end
  end
end
