require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { Game.create!(rows: 10, cols: 10, mines: 10) }

  describe "#board" do
    it "should return a board" do
      expect(subject.board).to be_a Board
      expect(subject.board.width).to eq(subject.rows)
      expect(subject.board.height).to eq(subject.cols)
      expect(subject.board.mines_count).to eq(subject.mines)
    end
  end
end
