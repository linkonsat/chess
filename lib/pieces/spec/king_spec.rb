# frozen_string_literal: true

require_relative '../king'
require_relative '../rook'
require_relative '../knight'
describe King do
  # test should describe a valid move? Any move is valid so long as it is not off board and does NOT go into check
  # King also can perform a castling move

  describe '#in_check?' do
    subject(:king) { described_class.new }

    it 'Does not allow king to move itself into check' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      pawn = double('Pawn', valid_move?: true, color: 'white')
      board.board[0][0] = king
      board.board[0][0].set_position([0, 0])
      board.board[2][1] = pawn
      expect(board.board[0][0].in_check?(board.board, [1, 0])).to eql(true)
    end

    it 'Does returns true when king is put into check' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      pawn = double('Pawn', valid_move?: true, color: 'white')
      board.board[0][0] = king
      board.board[1][1] = pawn
      expect(board.board[0][0].in_check?(board.board, [0, 0])).to eql(true)
    end
  end

  describe '#castleing_available?' do
    subject(:king) { described_class.new }

    it 'Allows casteling when the king or spaces are not under check.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      rook = double('Rook', color: 'black', valid_move?: false, name: 'Rook')
      bottom_king = King.new
      top_king = king
      board.board[0][4] = bottom_king
      board.board[7][4] = top_king
      board.board[0][0] = rook
      board.board[7][7] = rook
      board.board[0][7] = rook
      board.board[7][0] = rook
      board.board[0][4].color = 'black'
      board.board[7][4].color = 'black'
      board.board[0][4].set_position([0, 4])
      board.board[7][4].set_position([7, 4])
      expect(board.board[0][4].valid_move?(board.board, [0, 6])).to eql(true)
      expect(board.board[7][4].valid_move?(board.board, [7, 2])).to eql(true)
    end
    it 'Does not allow casteling when the king or spaces between casteling are under check' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      enemy_rook = double('Rook', valid_move?: true, color: 'black', name: 'Rook', status: 'enemy')
      board.board[0][4] = king
      board.board[0][0] = enemy_rook
      board.board[0][4].set_position([0, 4])
      expect(board.board[0][4].valid_move?(board.board, [0, 2])).to eql(false)
    end
  end

  describe '#valid_move?' do
    subject(:king) { described_class.new }

    it 'Does not allow valid moves outside of the board.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      board.board[0][0] = king
      board.board[0][0].set_position([0, 0])
      result = board.board[0][0].valid_move?(board.board, [-1, 8])
      expect(result).to eql(false)
    end

    it 'Allows valid moves in any square around it.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      board.board[4][4] = king
      board.board[4][4].set_position([4, 4])
      expect(board.board[4][4].valid_move?(board.board, [4, 3]))
    end
  end

  describe '#check_cause_pieces' do 
  subject(:king) { described_class.new }
  it 'Returns false when in check but another piece can capture the piece placeing it in check.' do
    board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
    king.color = 'black'
    king.set_position([0,7])
    enemy_piece = Rook.new
    enemy_piece.color = 'white'
    enemy_piece.set_position([7,7])
    enemy_piece_two = Rook.new 
    enemy_piece_two.color = 'white'
    enemy_piece_two.set_position([7,6])
    board.board[0][7] = king
    board.board[7][7] = enemy_piece
    board.board[7][6] = enemy_piece_two
    expect(king.check_cause_pieces).to eql(enemy_piece)
  end
end
  describe '#check_removal_pieces' do 
  subject(:king) { described_class.new }
  it 'Returns false when in check but another piece can capture the piece placeing it in check.' do
    board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
    king.color = 'black'
    king.set_position([0,7])
    enemy_piece = Rook.new
    enemy_piece.color = 'white'
    enemy_piece.set_position([7,7])
    enemy_piece_two = Rook.new 
    enemy_piece_two.color = 'white'
    enemy_piece_two.set_position([7,6])
    board.board[0][7] = king
    ally_piece = Knight.new 
    ally_piece.color = 'black'
    ally_piece.set_position([6,5])
    board.board[6][5] = ally_piece
    board.board[7][7] = enemy_piece
    board.board[7][6] = enemy_piece_two
    expect(king.check_removal_pieces).to eql(ally_piece)
  end
end
end
a = Array.new(3) { Array.new(3) { Array.new(3, 0) } }
b = [0,0,0]
found_axis = nil
i = 0
timesss = b.length + 1
timesss.times do 
    found_axis = a[i]
    puts found_axis[i]
  end