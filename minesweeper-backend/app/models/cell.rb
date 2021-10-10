class Cell
  attr_accessor :x, :y, :revealed, :flagged, :mine

  # Public: Returns the cell content.
  def to_s
    if revealed
      mine ? "x" : " "
    else
      flagged ? "F" : "*"
    end
  end
end