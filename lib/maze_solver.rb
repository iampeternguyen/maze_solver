class Solver


  def initialize(maze)
    @maze = maze
    @row, @col = @maze.start
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
    start = Path.new(nil, @row, @col)
    start.search(@maze.array)
    p start.open_nodes
    p start.closed_nodes
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

class Path
  attr_reader :parent, :row, :col, :open_nodes, :closed_nodes
  def initialize(parent, row, col)
    @parent = parent
    @row, @col = row,col
    @open_nodes = []
    @closed_nodes = []
    @child = nil
  end

  def search(maze_array)
    if @parent
      @open_nodes = @parent.open_nodes.clone
      @closed_nodes = @parent.closed_nodes.clone
    end

    row, col = @row + 1, @col
    node = maze_array[row][col]
    if node
      @open_nodes << [row,col] if node != "*" && !@open_nodes.include?([row,col])
      @closed_nodes << [row,col] if node == "*" && !@closed_nodes.include?([row,col])
    end


    row, col = @row - 1, @col
    node = maze_array[row][col]
    if node
      @open_nodes << [row,col] if node != "*" && !@open_nodes.include?([row,col])
      @closed_nodes << [row,col] if node == "*" && !@closed_nodes.include?([row,col])
    end


    row, col = @row, @col + 1
    node = maze_array[row][col]
    if node
      @open_nodes << [row,col] if node != "*" && !@open_nodes.include?([row,col])
      @closed_nodes << [row,col] if node == "*" && !@closed_nodes.include?([row,col])
    end


    row, col = @row, @col - 1
    node = maze_array[row][col]
    if node
      @open_nodes << [row,col] if node != "*" && !@open_nodes.include?([row,col])
      @closed_nodes << [row,col] if node == "*" && !@closed_nodes.include?([row,col])
    end


  end

  def best_node
    @open_nodes.each do |position|
      row, col = position

    end

  end


end

class Maze
  attr_reader :array, :start, :finish

  def initialize(maze_path)
    @array = []
    File.open(maze_path) do |f|
      f.each_line do |line|
        @array << line.strip.split("")
      end
    end

    @start = []
    @finish = []

    @array.each_with_index do |row, i|
      if row.include?("S")
        @start = [i, row.index("S")]
      end
      if row.include?("E")
        @finish = [i, row.index("E")]
      end
    end

  end


end


if __FILE__ == $PROGRAM_NAME
  maze = Maze.new(__dir__ + '/maze.txt')
  solver = Solver.new(maze)
  solver.auto_mode
end