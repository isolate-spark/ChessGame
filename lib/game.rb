require 'pp'
require_relative 'pieces'

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
    return false if coords.length != 2
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
    return false if coords.length != 2
    r = coords[0]
    c = coords[1]
    previous = @board.key(confirmed_piece)
    if valid?(previous, confirmed_piece, r, c)
      @board[previous] = EmptyChecker.new('replace')
      @board[[r, c]] = confirmed_piece
    else
      false
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
    print_board
  end
end

def shortest_path(piece, start, finish)
  move = piece.moves
  steps = 0
end

def make_pawns(g, c)
  n = 1
  a = 7
  a = 2 if c == 'black'
  8.times do
    pn = Pawn.new("Pawn#{n}#{c[0]}", c)
    g.build_game(pn, a, n)
    n += 1
  end
end

def new_game
  game = GamePlay.new
  game.fill_board

  make_pawns(game, 'white')
  rook1w = Rook.new('rook1w', 'white')
  rook2w = Rook.new('rook2w', 'white')
  knight2w = Knight.new('Knight2w', 'white')
  knight1w = Knight.new('Knight1w', 'white')
  knight2w = Knight.new('Knight2w', 'white')
  bishop1w = Bishop.new('Bishop1w', 'white')
  bishop2w = Bishop.new('Bishop2w', 'white')
  queenw = Queen.new('Queenw', 'white')
  kingw = King.new('Kingw', 'white')
  game.build_game(rook1w, 8, 1)
  game.build_game(rook2w, 8, 8)
  game.build_game(knight1w, 8, 2)
  game.build_game(knight2w, 8, 7)
  game.build_game(bishop1w, 8, 3)
  game.build_game(bishop2w, 8, 6)
  game.build_game(queenw, 8, 4)
  game.build_game(kingw, 8, 5)

  make_pawns(game, 'black')
  rook1b = Rook.new('rook1b', 'black')
  rook2b = Rook.new('rook2b', 'black')
  knight1b = Knight.new('Knight1b', 'black')
  knight2b = Knight.new('Knight2b', 'black')
  bishop1b = Bishop.new('Bishop1w', 'black')
  bishop2b = Bishop.new('Bishop2w', 'black')
  queenb = Queen.new('Queenb', 'black')
  kingb = King.new('Kingb', 'black')
  game.build_game(rook1b, 1, 1)
  game.build_game(rook2b, 1, 8)
  game.build_game(knight1b, 1, 2)
  game.build_game(knight2b, 1, 7)
  game.build_game(bishop1b, 1, 3)
  game.build_game(bishop2b, 1, 6)
  game.build_game(queenb, 1, 4)
  game.build_game(kingb, 1, 5)

  pp game.board
  game.print_board
  game.play_turn
end

new_game
