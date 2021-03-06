require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { create(:game, user: user) }

  include_context "game_with_fixed_board"

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "callbacks" do
    describe "before_create :update_settings_based_on_game_level" do
      context "when game level is beginner" do
        it "sets the rows to 10" do
          expect(subject.rows).to eq(10)
        end

        it "sets number of mines to 10" do
          expect(subject.mines).to eq(10)
        end
      end

      context "when game level is intermediate" do
        subject { create(:game, user: user, level: "intermediate") }

        it "sets number of rows to 16" do
          expect(subject.rows).to eq(16)
        end

        it "sets number of mines to 40" do
          expect(subject.mines).to eq(40)
        end
      end

      context "when game level is expert" do
        subject { create(:game, user: user, level: "expert") }

        it "sets the number of rows to 16" do
          expect(subject.rows).to eq(24)
        end

        it "sets the number of mines to 99" do
          expect(subject.mines).to eq(99)
        end
      end
    end
  end

  describe "#board" do
    it "should return a board" do
      expect(subject.board).to be_a Board
      expect(subject.board.width).to eq(subject.rows)
      expect(subject.board.height).to eq(subject.cols)
      expect(subject.board.mines_count).to eq(subject.mines)
    end

    context "when game.board_state is present" do
      let!(:game) { Game.find(subject.id) }

      it "it initializes a new board" do
        expect(game.board.new_board?).to be_truthy
      end
    end

    context "when game.board_state is present" do
      before do
        fixed_board.reveal(0, 0)
        subject.update!(board_state: fixed_board.to_a)
      end

      let!(:game) { Game.find(subject.id) }

      it "it loads the board from game.board_state" do
        expect(game.board.to_a).to eq(fixed_board.to_a)
      end
    end
  end

  describe "#play" do
    subject { game_with_fixed_board }

    it "should return false if the game is not won" do
      expect {
        subject.play do |game|
          game.board.reveal(0, 0)
          game.board.flag(0, 2)
        end
      }.to change { subject.board_state }

      expect(subject.board.at(0, 0).revealed?).to be_truthy
      expect(subject.board.at(0, 2).flagged?).to be_truthy
    end
  end

  describe "#won?" do
    include_context "game_with_fixed_board"

    before do
      allow(subject).to receive(:board).and_return(fixed_board)
    end

    it "should return false if the game is not won" do
      subject.board.reveal(0, 0)

      expect(subject.won?).to be false
    end

    describe "when all cells are revealed" do
      before do
        cells_list = subject.board.non_mines_cells

        subject.play do
          # reveal all non-mines cells except the last one
          while cells_list.size > 1
            cell = cells_list.shift
            cell.revealed = true
          end
        end
      end

      let!(:last_non_revealed_cell) { subject.board.non_mines_cells.reject(&:revealed?).first }

      it "should return true" do
        last_non_revealed_cell.reveal!
        expect(subject.won?).to be_truthy
      end
    end
  end

  describe "#time_elapsed_secs" do
    it "should return the time elapsed since the game started" do
      travel_to(subject.created_at + 5.minutes) do
        subject.update!(updated_at: Time.zone.now)
        expect(subject.time_elapsed_secs > 4.minutes).to be_truthy
      end
    end
  end
end
