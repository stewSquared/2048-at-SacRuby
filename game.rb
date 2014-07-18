class Game
  def initialize size=4
    @size = size
    @board = Array.new(@size) {Array.new(@size)}
    place()
    place()
  end

  def tile_at row, col
    @board[row][col]
  end

  def place
    def free? pos
      tile_at(*pos) == nil
    end

    pos = rand(@size), rand(@size)
    until free? pos
      pos = rand(@size), rand(@size)
    end
    row, col = pos
    @board[row][col] = 2
  end

  def slide dir
    def smash row
      row = row.select {|x| x}
      if row.length >= 2 and row[0] == row[1]
        row = [row.first*2] + row.drop(2)
      end
      if row.length >= 3
        row = row = [row.first] + smash(row.drop(1))
      end
      return row
    end
    def refill row
      row.fill(nil, row.length, @size - row.length)
    end
    def slide_left
      @board = @board.
        map {|_| smash _}.
        map {|_| refill _}
    end

    def flip_horiz
      @board = @board.map &:reverse
    end

    def flip_diag
      new_board = Array.new(@size) {Array.new(@size)}
      for col in 0...@size
        for row in 0...@size
          new_board[row][col] = @board[col][row]
        end
      end
      @board = new_board
    end
    
    case dir
    when 'L' then
      slide_left
    when 'R' then 
      flip_horiz
      slide_left
      flip_horiz
    when 'U' then
      flip_diag
      slide_left
      flip_diag
    when 'D' then
      flip_diag
      flip_horiz
      slide_left
      flip_horiz
      flip_diag
    end
    place()
  end
  
  def to_s
    @board.map do |row|
      row.map do |tile|
        tile == nil ? '.' : tile.to_s
      end.join(" ")
    end.join("\n")
  end
end


g = Game.new

while true
  puts g

  print "move? "
  dir = gets[0].upcase
  until "URLD".index(dir)
    print "move? "
    dir = gets[0].upcase
  end

  g.slide dir
end

