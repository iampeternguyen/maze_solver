class Node
  attr_reader :g

  def initialize(parent, position, finish)
    @row, @col = position
    @parent = parent
    @finish = finish
    @h = calculateH
    @g = calculateG
    @f = @h + @g
  end

  def calculateH
    row, col = @finish
    (row-@row).abs + (col-@col).abs
  end

  def calculateG
    @parent ? @parent.g + 1 : 0
  end

  def is_start?
    @parent == nil
  end

  def is_finish?
    row, col = finish
    @row == row && @col==col
  end
end