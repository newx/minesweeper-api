module Errors
  class CellAlreadyRevealedError < StandardError; end
  class CellDoesNotExistError < StandardError; end
  class MineFoundError < StandardError; end
  class GameOver < StandardError; end
end
