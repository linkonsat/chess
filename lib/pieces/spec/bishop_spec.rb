# frozen_string_literal: true

require_relative '../bishop'
# expect tests to be similar to to castle. Should be able to return a legal list of moves that include up to a unblocked path, enemy piece, and ally piece
describe Bishop do
  subject(:bishop) { described_class.new }
  describe '#valid_move?' do
    it 'Returns true up to a enemy piece' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      enemy_piece = double('EnemyPiece', color: 'purple')
      board.board[4][4] = bishop
      board.board[1][1] = enemy_piece
      board.board[4][4].set_position([4, 4])
      bishop.set_color('black')
      expect(board.board[4][4].valid_move?(board.board, [0, 0])).to eql(false)
      expect(board.board[4][4].valid_move?(board.board, [1, 1])).to eql(true)
    end
    it 'Returns false on a move outside the board boundaries' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      board.board[4][4] = bishop
      board.board[4][4].set_position([4, 4])
      bishop.set_color('black')
      expect(board.board[4][4].valid_move?(board.board, [99, 0])).to eql(false)
    end
    it 'Returns true on moves up to unblocked moves to the end of the board' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      board.board[4][4] = bishop
      board.board[4][4].set_position([4, 4])
      bishop.set_color('black')
      expect(board.board[4][4].valid_move?(board.board, [0, 0])).to eql(true)
    end

    it 'Returns true up to the space before an ally piece' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      ally_piece = double('AllyPiece', color: 'black')
      board.board[4][4] = bishop
      board.board[0][0] = ally_piece
      board.board[4][4].set_color('black')
      board.board[4][4].set_position([4, 4])
      expect(board.board[4][4].valid_move?(board.board, [0, 0])).to eql(false)
      expect(board.board[4][4].valid_move?(board.board, [1, 1])).to eql(true)
    end
  end
end
