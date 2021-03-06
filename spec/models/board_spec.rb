require 'rails_helper'

RSpec.describe Board, type: :model do
  subject { Board.new }

  before do
    subject.setup!
  end

  describe "#grid" do
    it "returns a grid with default size" do
      expect(subject.grid.length).to eq(Board::DEFAULT_WIDTH)
      expect(subject.grid[0].length).to eq(Board::DEFAULT_HEIGHT)
    end
  end

  describe "#to_table" do
    it "each printed column value matches a grid cell column values" do
      table = subject.to_table(force_reveal: true)

      puts table

      subject.grid.transpose.each_index do |column_index|
        column_values = subject.grid.transpose[column_index].map { |cell| cell.to_s(force_reveal: true) }
        expect(table.column(column_index)).to eq(column_values)
      end
    end
  end

  describe "#create_mines" do
    it "creates mines in the grid" do
      subject.send(:create_mines)

      puts subject.to_table

      expect(subject.grid.flatten.count(&:mine?)).to eq(Board::DEFAULT_MINES_COUNT)
    end
  end

  describe "#[]" do
    it "returns a grid cell" do
      expect(subject[0, 0]).to be_a(Cell)
    end
  end

  describe "#at" do
    it "returns a grid cell" do
      expect(subject[0, 0]).to be_a(Cell)
    end

    it "raises if cell does not exists" do
      expect { subject.at(100, 100) }.to raise_error(Errors::CellDoesNotExistError)
    end
  end

  describe "#load_state!" do
    include_context "game_with_fixed_board"

    it "loads a board state" do
      expect(subject.to_a).to_not eq(fixed_board.to_a)

      subject.load_state!(fixed_board.to_a)

      expect(subject.to_a).to eq(fixed_board.to_a)
      expect(subject.mines_coordinates).to eq(fixed_board.mines_coordinates)
    end
  end
end
