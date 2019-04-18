require_relative("maze.rb")
require_relative("node.rb")

class Solver
  def initialize(maze)
    @maze = maze
    @start = Node.new(nil, @maze.start, @maze.finish)
    @open_nodes = []
    @closed_nodes = []
    @open_nodes << @start
    @movement = maze.array.clone
  end

  def manual_mode
    print_movement


    while true
      input = gets.chomp
      move(input)
    end
  end

  def auto_mode
    target_found = false

    # @open_nodes << Node.new(nil, [6,2], @maze.finish)
    # @open_nodes << Node.new(nil, [5,2], @maze.finish)

    # @open_nodes << Node.new(nil, [3,1], @maze.finish)


    sort_open_nodes
    i = 0
    while i < 3
      current_node = sort_open_nodes[0]

      find_and_add_nearest_nodes(current_node)
      i += 1
    end
    p @open_nodes

  end

  def find_and_add_nearest_nodes(current_node)

    row, col = current_node.row + 1, current_node.col
    add_node(row, col, current_node)

    row, col = current_node.row - 1, current_node.col
    add_node(row, col, current_node)

    row, col = current_node.row , current_node.col + 1
    add_node(row, col, current_node)

    row, col = current_node.row , current_node.col - 1
    add_node(row, col, current_node)
  end

  def add_node(row,col,current_node)
    node = @maze.array[row][col]
    if node
      new_node = Node.new(current_node, [row,col], @maze.finish)

      if @open_nodes.none? {|open_node| open_node == new_node} && node != "*"
        @open_nodes << new_node
      elsif @closed_nodes.none? {|closed_node| closed_node == new_node} && node == "*"
        @closed_nodes << new_node
      end
    end
  end

  def sort_open_nodes
    @open_nodes.sort! {|x,y| x.f <=> y.f}
  end

  def print_movement
    @movement.each {|row| p row}
  end

  def move(direction)
    row, col = @row,@col
    if direction == "u"
      row -= 1
    end
    if direction == "d"
      row += 1
    end
    if direction == "l"
      col -= 1
    end
    if direction == "r"
      col += 1
    end

    if @movement[row][col] != "*"
      @row,@col = row,col
      @movement[@row][@col] = "X"
    else
      puts "invalid direction"
    end

    print_movement
    sleep(2)
  end

end

# class Path
#   attr_reader :parent, :row, :col, :open_nodes, :closed_nodes
#   def initialize(parent, row, col)
#     @parent = parent
#     @row, @col = row,col
#     @open_nodes = []
#     @closed_nodes = []
#     @child = nil
#   end

#   def search(maze_array)
#     if @parent
#       @open_nodes = @parent.open_nodes.clone
#       @closed_nodes = @parent.closed_nodes.clone
#     end

#     row, col = @row + 1, @col
#     node = maze_array[row][col]
#     if node
#       @open_nodes << [row,col] if node != "*" && !@open_nodes.include?([row,col])
#       @closed_nodes << [row,col] if node == "*" && !@closed_nodes.include?([row,col])
#     end


#     row, col = @row - 1, @col
#     node = maze_array[row][col]
#     if node
#       @open_nodes << [row,col] if node != "*" && !@open_nodes.include?([row,col])
#       @closed_nodes << [row,col] if node == "*" && !@closed_nodes.include?([row,col])
#     end


#     row, col = @row, @col + 1
#     node = maze_array[row][col]
#     if node
#       @open_nodes << [row,col] if node != "*" && !@open_nodes.include?([row,col])
#       @closed_nodes << [row,col] if node == "*" && !@closed_nodes.include?([row,col])
#     end


#     row, col = @row, @col - 1
#     node = maze_array[row][col]
#     if node
#       @open_nodes << [row,col] if node != "*" && !@open_nodes.include?([row,col])
#       @closed_nodes << [row,col] if node == "*" && !@closed_nodes.include?([row,col])
#     end


#   end

#   def best_node
#     @open_nodes.each do |position|
#       row, col = position

#     end

#   end


# end




if __FILE__ == $PROGRAM_NAME
  maze = Maze.new(__dir__ + '/maze.txt')
  solver = Solver.new(maze)
  solver.auto_mode
end