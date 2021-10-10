require 'rails_helper'

RSpec.describe Board, type: :model do
  subject { Board.new }

  describe "#grid" do
    it "returns a grid with default size" do
      expect(subject.grid.length).to eq(Board::DEFAULT_WIDTH)
      expect(subject.grid[0].length).to eq(Board::DEFAULT_HEIGHT)
    end
  end

  describe "#to_table" do
    it "each printed grid cell matches a grid cell position" do
      table = subject.to_table

      puts table

      subject.grid.transpose.each_index do |column_index|
        expect(table.column(column_index)).to eq(subject.grid.transpose[column_index].map(&:to_s))
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
end
