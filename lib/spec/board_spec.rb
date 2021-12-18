# frozen_string_literal: true
require_relative '../pieces/pawn'
# tests should test if a board spot can be changed
# a set containing board pieces is properly laid according to the format in the set
require 'pry-byebug'
require_relative '../board'
describe Board do
  describe '#initial_board' do
    subject(:board) { described_class.new }
    it 'It creates a blank new board initially' do
      checked_length = []
      board.board.each { |row| checked_length.push(row.length) }
      expect(board.board.length).to eql(8)
    end
  end
  describe '#place_sets' do
    subject(:board) { described_class.new }
    it 'Sets pieces in the same row as the piece set' do
      pawn = Pawn.new
      set_one = Array.new(2) { Array.new(8, pawn) }
      set_two = Array.new(2) { Array.new(8, pawn) }
      subject.set_pieces_standard(set_one, set_two)
      expect(board.board[0].all?(pawn)).to eql(true)
      expect(board.board[1].all?(pawn)).to eql(true)
      expect(board.board[7].all?(pawn)).to eql(true)
      expect(board.board[6].all?(pawn)).to eql(true)
    end
  end
  describe '#update_board' do
    subject(:board) { described_class.new }
    it 'Updates the board when given new coordinates.' do
      pawn = double('Pawn', current_position: [5, 5])
      board.board[5][5] = pawn
      new_coordinates = [5, 5]
      board.update_board(pawn, new_coordinates)
      expect(board.board[5][5]).to eql(pawn)
    end

    it 'Updates the board when a passant move from pawn is entered' do
      pawn = double('Pawn', current_position: [1, 1])
      pawn_enemy = double('Pawn')
      board.board[1][0] = pawn_enemy
      board.update_board(pawn, [0, 0])
      expect(board.board[0][0]).to eql(pawn)
      expect(board.board[1][0]).not_to eql(pawn_enemy)
    end
    it 'Updates the board when king does a castling move.' do
      castle = double('Castle')
      king = double('King', :current_position => [0, 4])
      board.board[0][0] = castle
      board.board[0][4] = king
      board.update_board(king, [0, 2])
      expect(board.board[0][2]).to eql(king)
      expect(board.board[0][3]).to eql(castle)
    end
    it "Replaces the old piece spot with a blank spot." do
    castle = double('Castle', :current_position => [0,3])
    board.board[0][3] = castle
    board.update_board(castle,[0,0])
    expect(board.board[0][3]).not_to eql(castle)
    expect(board.board[0][0]).to eql(castle)
  end
end
end
