require 'rails_helper'

RSpec.describe Cell, type: :model do
  let!(:board) do
    Board.new.tap do |b|
      b.setup!
    end
  end

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
        expect(subject.to_s).to eq("?")
      end
    end
  end

  describe "#neighbor_mines_count" do
    include_context "game_with_fixed_board"

    it "returns the expected neighbors_count values" do
      puts fixed_board.to_table(force_reveal: true)

      rendered_grid = fixed_board.to_a(force_reveal: true, render: true)

      rendered_grid.each_with_index do |row, row_index|
        row.each_with_index do |cell_value, col_index|
          cell = fixed_board.at(row_index, col_index)
          cell.revealed = true

          expect(cell.neighbors_count_to_s).to eq(cell_value) unless cell.mine?
        end
      end
    end
  end

  describe "#reveal!" do
    include_context "game_with_fixed_board"

    let!(:expected_revealed_cells_coords) do
      [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [0, 8], [0, 9], [1, 0], [1, 6], [1, 7], [1, 8], [1, 9], [2, 8], [2, 9], [3, 8], [3, 9]]
    end

    it "recursively reveal neighbors cells with no neighbors mines" do
      puts "Before reveal"
      puts fixed_board.to_table

      cell = fixed_board.at(0, 0)
      revealed_cells = cell.reveal!

      expect(revealed_cells.map(&:to_c).sort).to eq(expected_revealed_cells_coords)

      puts "After revealing cell (0, 0)"
      puts fixed_board.to_table

      expect(fixed_board.grid[0].map(&:to_s)).to eq([" ", " ", " ", " ", " ", " ", " ", " ", " ", " "])
      expect(fixed_board.grid[1].map(&:to_s)).to eq([" ", "*", "*", "*", "*", "*", " ", " ", " ", " "])
      expect(fixed_board.grid[2].map(&:to_s)).to eq(["*", "*", "*", "*", "*", "*", "*", "*", " ", " "])
      expect(fixed_board.grid[3].map(&:to_s)).to eq(["*", "*", "*", "*", "*", "*", "*", "*", " ", " "])
    end
  end

  describe "#flag!" do
    it "flags the cell" do
      subject.flag!
      expect(subject.flagged).to be_truthy
    end
  end
end
