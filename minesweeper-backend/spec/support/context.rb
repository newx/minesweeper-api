shared_context "board_with_fixed_mines" do
  let!(:fixed_mines_coordinates) do
    [[2, 4], [2, 2], [3, 2], [3, 6], [3, 1], [4, 3], [4, 6], [5, 9], [5, 6], [9, 1]]
  end

  # Fixed board representation
  # +---+---+---+---+---+---+---+---+---+---+
  # |   |   |   |   |   |   |   |   |   |   |
  # +---+---+---+---+---+---+---+---+---+---+
  # |   | 1 | 1 | 2 | 1 | 1 |   |   |   |   |
  # +---+---+---+---+---+---+---+---+---+---+
  # | 1 | 3 | x | 3 | x | 2 | 1 | 1 |   |   |
  # +---+---+---+---+---+---+---+---+---+---+
  # | 1 | x | x | 4 | 2 | 3 | x | 2 |   |   |
  # +---+---+---+---+---+---+---+---+---+---+
  # | 1 | 2 | 3 | x | 1 | 3 | x | 3 | 1 | 1 |
  # +---+---+---+---+---+---+---+---+---+---+
  # |   |   | 1 | 1 | 1 | 2 | x | 2 | 1 | x |
  # +---+---+---+---+---+---+---+---+---+---+
  # |   |   |   |   |   | 1 | 1 | 1 | 1 | 1 |
  # +---+---+---+---+---+---+---+---+---+---+
  # |   |   |   |   |   |   |   |   |   |   |
  # +---+---+---+---+---+---+---+---+---+---+
  # | 1 | 1 | 1 |   |   |   |   |   |   |   |
  # +---+---+---+---+---+---+---+---+---+---+
  # | 1 | x | 1 |   |   |   |   |   |   |   |
  # +---+---+---+---+---+---+---+---+---+---+
  let(:fixed_board) do
    board = Board.new
    board.setup!
    board.reset_mines!
    board.create_fixed_mines!(fixed_mines_coordinates)
    board.reveal(0, 0)
    board.reveal(0, 1)
    board.reveal(0, 2)

    board
  end
end
