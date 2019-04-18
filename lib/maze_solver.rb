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

  def auto_mode
    target_found = false

    while !target_found
      sort_open_nodes
      current_node = @open_nodes[0]
      @closed_nodes << @open_nodes.shift
      if current_node.is_finish?
        target_found = true
        break
      end
      find_and_add_nearest_nodes(current_node)
    end
    @movement = @maze.array.clone
    draw_path(current_node)
  end

  def draw_path(current_node)
    @movement[current_node.row][current_node.col] = "X"
    print_movement
    sleep(0.5)
    if current_node.parent
      draw_path(current_node.parent)
    end
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

      @closed_nodes.each do |closed_node|
        return nil if new_node == closed_node
      end

      @open_nodes.each_with_index do |open_node, index|
        if new_node == open_node
          @open_nodes[index] = new_node
          return new_node
        end
      end

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
end

if __FILE__ == $PROGRAM_NAME
  maze = Maze.new(__dir__ + '/maze.txt')
  solver = Solver.new(maze)
  solver.auto_mode
end