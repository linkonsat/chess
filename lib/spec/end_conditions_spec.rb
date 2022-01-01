# frozen_string_literal: true

require_relative '../end_conditions'
require_relative '../pieces/rook'
require_relative '../pieces/king'
require_relative '../pieces/knight'
require 'pry-byebug'
describe EndConditions do
  describe '#checkmate' do
    subject(:end_conditions) { described_class.new }
    it 'Returns true on king being stuck in checkmate' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      king = King.new 
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
      expect(end_conditions.checkmate?(board.board)).to eql(true)
    end
    it "Does not return true when surrounded by friendly pieces." do 
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      king = King.new 
      king.color = 'black'
      king.set_position([0,0])
      ally = Rook.new 
      ally.color = 'black'
      ally.set_position([0,1])
      ally_two = Rook.new 
      ally_two.color = 'black'
      ally_two.set_position([1,1])
      ally_three = Rook.new 
      ally_three.color = 'black'
      ally_three.set_position([1,0])
      board.board[0][0] = king 
      board.board[0][1] = ally 
      board.board[1][1] = ally_two
      board.board[1][0] = ally_three 
      expect(end_conditions.checkmate?(board.board)).to eql(false)
    end
    
    it 'Returns false when in check but another piece can capture the piece placeing it in check.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      king = King.new 
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
      expect(end_conditions.checkmate?(board.board)).to eql(false)
    end
    

    it 'Returns false when king can move out of checkmate.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      king = King.new 
      king.color = 'black'
      king.set_position([0,7])
      enemy_piece = Rook.new
      enemy_piece.color = 'white'
      enemy_piece.set_position([1,0])
      board.board[4][4] = king
      board.board[7][4] = enemy_piece
      expect(end_conditions.checkmate?(board.board)).to eql(false)
    end

 

    it 'Returns false when king can capture a piece to move out of checkmate.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      king = King.new 
      king.color = 'black'
      king.set_position([0,7])
      enemy_piece = Rook.new
      enemy_piece.color = 'white'
      enemy_piece.set_position([1,0])
      board.board[0][7] = king
      board.board[1][7] = enemy_piece
      expect(end_conditions.checkmate?(board.board)).to eql(false)
    end
  
    it 'Returns false if any square around the king is not in check' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      king = instance_double('King', color: 'black', legal_moves: [[1, 2]], class: 'King')
      new_king = King.new
      new_king.set_color('black')
      new_king.set_position([4, 4])
      enemy_piece = instance_double('Piece', valid_move?: false, color: 'black')
      board.board[4][4] = enemy_piece
      board.board[0][0] = new_king
      expect(end_conditions.checkmate?(board.board)).to eql(false)
    end

  end
  describe '#resignation?' do
    subject(:end_conditions) { described_class.new }
    it 'Returns true if a player enters resign' do
      resignation = 'resign'
      expect(end_conditions.resignation?(resignation)).to eql(true)
    end
    it 'Returns false if a player enters anything other than resign' do
      no_resignation = 'no resignation'
      expect(end_conditions.resignation?(no_resignation)).to eql(false)
    end
  end

  describe '#stalemate?' do
    subject(:end_conditions) { described_class.new }
    it 'Returns true when only kings are left on the board' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      king = double('King', color: 'black', class: 'King')
      second_king = double('king', color: 'purple', class: 'King')
      board.board[4][4] = king
      board.board[0][0] = second_king
      expect(end_conditions.stalemate?(board.board)).to eql(true)
    end

    it 'Returns true when only a king and bishop or knight are left' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      king = double('King', color: 'black', class: 'King')
      knight = double('Knight', color: 'purple', class: 'Knight')
      second_king = double('King', color: 'purple', class: 'King')
      bishop = double('Bishop', color: 'black', class: 'Bishop')
      board.board[4][4] = king
      board.board[0][0] = knight
      board.board[0][7] = bishop
      board.board[7][5] = second_king
      expect(end_conditions.stalemate?(board.board)).to eql(true)
    end
    it 'Returns false when conditions are not met' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      king = double('King', color: 'black')
      knight = double('Knight', color: 'purple')
      second_king = double('king', color: 'purple')
      rook = double('Rook', color: 'purple')
      board.board[4][4] = king
      board.board[0][0] = knight
      board.board[7][5] = second_king
      board.board[0][4] = rook
      expect(end_conditions.stalemate?(board.board)).to eql(false)
    end
  end

  describe '#fifty_moves?' do
    subject(:end_conditions) { described_class.new }
    it 'Returns true when move count reaches 50' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      rook = double('Rook', legal_moves: [[0, 0], [1, 1]])
      main_game = double('MainGame', no_capture_count: 50)
      expect(end_conditions.fifty_moves?(main_game.no_capture_count)).to eql(true)
    end
    it 'Returns false when move count is not 50.' do
      board = double('Board', :board => Array.new(8) { Array.new(8, '[]') })
      rook = double('Rook', :legal_moves => [[0, 0], [1, 1]])
      main_game = double('MainGame', no_capture_count: 25)
      expect(end_conditions.fifty_moves?(main_game.no_capture_count)).to eql(false)
    end
  end

  describe '#repetition?' do
    subject(:end_conditions) { described_class.new }
    it 'Returns true when board state is repeated five times' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      rook = double('Rook', color: 'black')
      captured_piece = double('Pawn', :color => 'white')
      main_game = double('MainGame', :return_history => [[board.board], [board.board], [board.board], [board.board], [board.board]])
      expect(end_conditions.repetition?(main_game)).to eql(true)
    end
    it 'Returns false when the board state is not repeated five times' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      changed_board = double('BoardNew', :board => Array.new(8) { Array.new(8, '[]') })
      enemy_piece = double('EnemyPiece', :legal_moves => [1, 2])
      changed_board.board[5][5] = enemy_piece
      rook = double('Rook', color: 'black')
      captured_piece = double('Pawn', :color => 'white')
      main_game = double('MainGame', :return_history => [[changed_board.board], [changed_board.board], [board.board], [board.board]])
      expect(end_conditions.repetition?(main_game)).to eql(false)
    end
  end
end
