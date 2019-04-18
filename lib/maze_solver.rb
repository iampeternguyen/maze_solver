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
    start.find_open(@maze.array)
    p start.open_nodes
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
  attr_reader :parent, :row, :col, :open_nodes, :closed
  def initialize(parent, row, col)
    @parent = parent
    @row, @col = row,col
    @open_nodes = []
    @closed_nodes = []
    @child = nil
  end

  def find_open(maze_array)
    if @parent
      @open_nodes = @parent.open_nodes.clone
    end

    row, col = @row + 1, @col
    node = maze_array[row][col]
    @open_nodes << [row,col] if node != "*" && !@open_nodes.include?([row,col])
    @closed_nodes << [row,col] if node == "*" && !@closed_nodes.include?([row,col])

    row, col = @row - 1, @col
    node = maze_array[row][col]
    @open_nodes << [row,col] if node != "*" && !@open_nodes.include?([row,col])
    @closed_nodes << [row,col] if node == "*" && !@closed_nodes.include?([row,col])

    row, col = @row, @col + 1
    node = maze_array[row][col]
    @open_nodes << [row,col] if node != "*" && !@open_nodes.include?([row,col])
    @closed_nodes << [row,col] if node == "*" && !@closed_nodes.include?([row,col])

    row, col = @row, @col - 1
    node = maze_array[row][col]
    @open_nodes << node if node != "*" && !@open_nodes.include?([row,col])
    @closed_nodes << node if node == "*" && !@closed_nodes.include?([row,col])

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