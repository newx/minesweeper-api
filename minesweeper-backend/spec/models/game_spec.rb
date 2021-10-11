require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { create(:game) }

  describe "#board" do
    it "should return a board" do
      expect(subject.board).to be_a Board
      expect(subject.board.width).to eq(subject.rows)
      expect(subject.board.height).to eq(subject.cols)
      expect(subject.board.mines_count).to eq(subject.mines)
    end
  end

  describe "#won?" do
    include_context "board_with_fixed_mines"

    before do
      allow(subject).to receive(:board).and_return(fixed_board)
    end

    it "should return false if the game is not won" do
      subject.board.reveal(0, 0)
      subject.board.reveal(0, 1)

      expect(subject.won?).to be false
    end

    it "should return true if the game is won" do
      subject.board.flag_all_mines!
      expect(subject.won?).to be_truthy
    end
  end

  describe "before_save :save_board_state" do
    include_context "board_with_fixed_mines"

    before do
      allow(subject).to receive(:board).and_return(fixed_board)

      # Changes the board state
      subject.board.reveal(0, 0)
      subject.board.reveal(0, 1)
      subject.board.at(0, 2).flag!
    end

    let!(:new_board_state) { subject.board.to_a }

    it "should save the board state" do
      subject.save!

      expect(subject.reload.board_state.to_json).to eq(new_board_state.to_json)
    end
  end
end
