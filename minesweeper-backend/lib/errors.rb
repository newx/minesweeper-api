module Errors
  class CellDoesNotExistError < StandardError; end

  class MineFoundError < StandardError; end

  class GameOver < StandardError; end
end
