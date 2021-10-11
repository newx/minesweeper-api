shared_context "board_with_fixed_mines" do
  let!(:fixed_mines_coordinates) do
    [[2, 4], [2, 2], [3, 2], [3, 6], [3, 1], [4, 3], [4, 6], [5, 9], [5, 6], [9, 1]]
  end

  let!(:board) do
    board_instance = Board.new
    board_instance.reset_mines!
    board_instance.create_fixed_mines(fixed_mines_coordinates)

    board_instance
  end
end
