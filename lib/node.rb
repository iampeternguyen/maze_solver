class Node
  attr_reader :g, :row, :col, :f, :h

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
    p row
    p col
    (row - self.row).abs + (col-self.col).abs
  end

  def ==(other_node)
    self.row == other_node.row && self.col == other_node.col
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