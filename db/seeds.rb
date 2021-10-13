# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(
  email: "newx@example.com",
  first_name: "Newton",
  last_name: "Garcia",
  password: "123456",
  password_confirmation: "123456"
)

game_1 = Game.create!(
  user: user,
  rows: 10,
  cols: 10,
  mines: 10
)

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
fixed_mines = [[2, 4], [2, 2], [3, 2], [3, 6], [3, 1], [4, 3], [4, 6], [5, 9], [5, 6], [9, 1]]

fixed_board = Board.new
fixed_board.setup!
fixed_board.create_fixed_mines!(fixed_mines)
fixed_board.reveal(0, 0)

game_2 = Game.create!(
  user: user,
  rows: 10,
  cols: 10,
  mines: 10
)

game_2.board.load_state!(fixed_board.to_a)
