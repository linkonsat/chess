# frozen_string_literal: true
require 'pry-byebug'
require_relative '../board'
require_relative '../pieces/pawn'
require_relative '../pieces/rook'
require_relative '../player_set'
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
      pawn = double('Pawn', current_position: [4, 5], set_position: [])
      board.board[5][5] = pawn
      new_coordinates = [5, 5]
      board.update_board(pawn, new_coordinates)
      expect(board.board[5][5]).to eql(pawn)
    end

    it 'Updates the board when a passant move from pawn is entered' do
      pawn = Pawn.new
      pawn.set_position([1, 1])
      pawn_enemy = Pawn.new
      pawn_enemy.set_position([2, 0])
      pawn_enemy.set_position([0, 0])
      board.board[0][0] = pawn_enemy
      board.board[0][1] = pawn
      board.update_board(pawn, [1, 0])
      expect(board.board[1][0]).to eql(pawn)
    end
    it 'Updates the board when king does a castling move.' do
      castle = double('Castle', set_position: [])
      king = double('King', current_position: [0, 4], set_position: [], class: 'King')
      board.board[0][0] = castle
      board.board[0][4] = king
      board.update_board(king, [0, 2])
      expect(board.board[0][2]).to eql(king)
      expect(board.board[0][3]).to eql(castle)
    end
    it 'Replaces the old piece spot with a blank spot.' do
      castle = double('Castle', current_position: [0, 3], set_position: [])
      board.board[0][3] = castle
      board.update_board(castle, [0, 0])
      expect(board.board[0][3]).not_to eql(castle)
      expect(board.board[0][0]).to eql(castle)
    end
  end

  describe '#promotion_replacement' do
    subject(:board) { described_class.new }
    it 'Changes board position to new piece type when prompted.' do
      new_piece = Rook.new
      moved_piece = Pawn.new
      board.board[0][0] = moved_piece
      moved_piece.current_position = [0, 0]
      board.promotion_replacement(new_piece, [0, 0])
      expect(board.board[0][0]).to eql(new_piece)
    end
  end

  describe '#notation' do 
  subject(:board) { described_class.new }
  it "Saves the pieces on the board." do 
    set = ChessSet.new
    black_set = set.create_black_set 
    white_set = set.create_white_set
    board.set_pieces_standard(white_set,black_set)
    data = board.notation
    found_occurence = data.count "R"
    expect(found_occurence).to eql(2)
  end
end
describe '#create_data' do
subject(:board) {described_class.new }
it "Returns the right piece when given the correct data" do 
  data_hash = board.create_data("p||[1, 6]|[]|")
  expect(data_hash).to eql({:piece=>"p", :color=>"white", :previous_position=>nil, :current_position=>[1, 6]})
end
it "Returns the right piece when given the correct nested data" do 
  data_hash = board.create_data("p||[1, 6]|[[2, 5]]|[]|")
  expect(data_hash).to eql({:piece=>"p", :color=>"white", :previous_position=>nil, :current_position=>[1, 6], :available_moves_values => [[2, 5]]})
end
end
  describe '#saved_board_setup' do  
  subject(:board) {described_class.new}
  it "Generates the saved board from the saved board notation." do 
    set = ChessSet.new
    black_set = set.create_black_set 
    white_set = set.create_white_set
    board.set_pieces_standard(white_set,black_set)
    data = board.notation
    second_board = Board.new
    second_board.saved_board_setup(data)
    expect(second_board.display_used_board).to eql(board.display_used_board)
  end
end

end
