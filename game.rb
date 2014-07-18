class Game
  def initialize
    @board = Array.new(4) {Array.new(4)}
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

    pos = rand(4), rand(4)
    until free? pos
      pos = rand(4), rand(4)
    end
    row, col = pos
    @board[row][col] = 2
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

puts g
