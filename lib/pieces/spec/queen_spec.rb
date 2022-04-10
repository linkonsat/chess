# frozen_string_literal: true

require '../queen'
describe Queen do
  describe '#valid_move' do
    subject(:queen) { described_class.new }
    it 'Allows a move up to the end of the board if unblocked.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      board.board[4][4] = queen
      board.board[4][4].set_position([4, 4])
      board.board[4][4].set_color('black')
      expect(board.board[4][4].valid_move?(board.board, [0, 0])).to eql(true)
      expect(board.board[4][4].valid_move?(board.board, [4, 7])).to eql(true)
      expect(board.board[4][4].valid_move?(board.board, [0, 4])).to eql(true)
      expect(board.board[4][4].valid_move?(board.board, [7, 7])).to eql(true)
    end
    it 'Allows a move up to an enemy piece.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      enemy_piece = double('EnemyPiece', color: 'purple')
      board.board[4][4] = queen
      board.board[4][1] = enemy_piece
      board.board[4][4].set_position([4, 4])
      board.board[4][4].set_color('black')
      expect(board.board[4][4].valid_move?(board.board, [4, 1])).to eql(true)
      expect(board.board[4][4].valid_move?(board.board, [4, 0])).to eql(false)
    end
    it 'Allows a move up to the square before an ally piece.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      ally_piece = double('AllyPiece', color: 'black')
      board.board[4][4] = queen
      board.board[4][0] = ally_piece
      board.board[4][4].set_color('black')
      board.board[4][4].set_position([4, 4])
      expect(board.board[4][4].valid_move?(board.board, [4, 1])).to eql(true)
      expect(board.board[4][4].valid_move?(board.board, [4, 0])).to eql(false)
    end
    it 'Does not allow a move outside of the board' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      board.board[4][4] = queen
      board.board[4][4].set_position([4, 4])
      expect(board.board[4][4].valid_move?(board.board, [99, 99])).to eql(false)
    end
  end
end
