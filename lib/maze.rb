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