require 'pp'
require './lib/game_pieces.rb'

class Board
  attr_accessor :board
  def initialize
    @board = {}
  end



  def build_game(piece, row, col)
      @board[[row, col]] = piece
  end

  def fill_board
    x = 1
    y = 1
    8.times do
      8.times do
        check = EmptyChecker.new("Checker#{x.to_s}#{y.to_s}")
        build_game(check, x, y)
        y += 1
      end
      y = 1
      x += 1
    end
  end

    def print_board
      arr = [1, 2, 3, 4, 5, 6, 7, 8]
      values = @board.values
      values.each { |v| arr << v.instance_variable_get("@sym")}
      a = 0
      b = 7
      c = 0
      9.times do
        p_arr = arr[a..b].unshift(c).join(' ')
        a += 8
        b += 8
        c += 1
        puts p_arr
      end
    end
end

class GamePlay < Board

  def piece_locator
    puts "Type the row # followed by the column # to select a piece to move."
    coords = gets.chomp.split('').map(&:to_i)
    row = coords[0]
    col = coords[1]
    piece = @board.fetch([row, col])
    if piece.instance_variable_defined?('@moves')
      @board.fetch([row, col])
    else
      puts "No chess piece exists at this spot. Try again."
      false
    end
  end

  def valid?(old_position, p, row, col)
    if row < 1 || row > 8 || col < 1 || col > 8
      puts "That's off the board! Try again"
      false
    elsif !p.moves.include? [(row - old_position[0]), (col - old_position[1])]
      puts "Invalid move, try again."
      false
    else
      true
    end
  end

  def piece_mover(confirmed_piece)
    puts "Type the row # followed by the column # you want to move the piece to."
    puts confirmed_piece
    coords = gets.chomp.split('').map(&:to_i)
    r = coords[0]
    c = coords[1]
    previous = @board.key(confirmed_piece)
    if valid?(previous, confirmed_piece, r, c)
      @board[[r, c]] = [confirmed_piece]
    end
  end

  def play_turn
    piece = false
    piece_move = false
    while piece == false
      piece = piece_locator
    end
    while piece_move == false
      piece_move = piece_mover(piece)
    end
  end
end

def shortest_path(piece, start, finish)
  move = piece.moves
  steps = 0
end

game = GamePlay.new
game.fill_board
knight = Knight.new('Knight 1', 'white', '♘')
game.build_game(knight, 1, 2)
pp game.board
game.print_board
game.play_turn
game.print_board

