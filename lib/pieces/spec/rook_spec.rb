# frozen_string_literal: true

require_relative '../rook'
require_relative "../king"
describe Rook do
  describe '#valid_move?' do
    subject(:rook) { described_class.new }

    it 'Allows a valid move up to one space before a allied piece' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      ally_piece = double('AllyPiece', color: 'black')
      board.board[4][4] = rook
      board.board[4][4].set_position([4, 4])
      board.board[4][2] = ally_piece
      board.board[4][4].set_color('black')
      expect(board.board[4][4].valid_move?(board.board, [4, 2])).to eql(false)
      expect(board.board[4][4].valid_move?(board.board, [4, 3])).to eql(true)
    end

    it 'Allows a valid move up to a enemy piece' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      enemy_piece = double('EnemyPiece', color: 'purple')
      board.board[4][4] = rook
      board.board[4][4].set_position([4, 4])
      board.board[4][1] = enemy_piece
      board.board[4][4].set_color('black')
      expect(board.board[4][4].valid_move?(board.board, [4, 0])).to eql(false)
      expect(board.board[4][4].valid_move?(board.board, [4, 1])).to eql(true)
    end

    it 'Returns false on a invalid move direction' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })

      board.board[4][4] = rook
      board.board[4][4].set_position([4, 4])
      expect(board.board[4][4].valid_move?(board.board, [99, 99])).to eql(false)
    end

    it 'Allows a valid move to the end of the board state when unblocked' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      board.board[4][4] = rook
      board.board[4][4].color = 'black'
      board.board[4][4].set_position([4, 4])
      expect(board.board[4][4].valid_move?(board.board, [4, 0])).to eql(true)
      expect(board.board[4][4].valid_move?(board.board, [1, 4])).to eql(true)
      expect(board.board[4][4].valid_move?(board.board, [7, 4])).to eql(true)
      expect(board.board[4][4].valid_move?(board.board, [4, 7])).to eql(true)
    end

    it "Does not allow a valid move if the king would be in check" do 
      board = double('Board', :board => Array.new(8) { Array.new(8, "[]")})
      king = King.new 
      king.set_position([0,0])
      king.color = "Black"
      rook.color = "Black" 
      rook.set_position([1,0])
      enemy_rook = Rook.new
      enemy_rook.color = "White"
      enemy_rook.set_position([7,0])
      board.board[0][0] = king 
      board.board[1][0] = rook
      board.board[7][0] = enemy_rook
      expect(board.board[1][0].valid_move?(board.board,[1,7])).to eql(false)
      expect(board.board[1][0].valid_move?(board.board,[5,0])).to eql(true)
    end
  end
end
