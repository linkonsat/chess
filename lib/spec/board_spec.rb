#tests should test if a board spot can be changed
#a set containing board pieces is properly laid according to the format in the set
require_relative "../board"
describe Board do 
    describe "#initial_board" do 
    subject(:board) { described_class.new }
    it "It creates a blank new board initially" do 
        checked_length = []
        board.board.each { |row| checked_length.push(row.length)}
        expect(board.board.length).to eql(8)
    end
end
    describe "#place_sets" do 
    subject(:board) { described_class.new }
    it "Sets pieces in the same row as the piece set" do 
        set_one = Array.new(2) { Array.new(8, 1)}
        set_two = Array.new(2) {Array.new(8, 2)}
        subject.set_pieces_standard(set_one,set_two)
        expect(board.board[0].all?(1)).to eql(true)
        expect(board.board[1].all?(1)).to eql(true)
        expect(board.board[7].all?(2)).to eql(true)
        expect(board.board[6].all?(2)).to eql(true)
    end
end
    describe "#update_board" do 
    subject(:board) { described_class.new }
    it "Updates the board when given new coordinates." do 
        pawn = double("Pawn")
        board.board[0][0] = pawn
        new_coordinates = [5,5]
        board.update_board(pawn,new_coordinates)
        expect(board.board[5][5]).to eql(pawn)
    end

    it "Updates the board when a passant move from pawn is entered" do 
    pawn = double("Pawn", :current_position => [1,1])
    pawn_enemy = double("Pawn")
    board.board[1][0] = pawn_enemy
    board.update_board(pawn,[0,0])
    end
    it "Updates the board when king does a castling move." do 
    castle = double("Pawn")
    king = double("Pawn")
    board.board[0][0] = castle
    board.board[0][4] = king
    board.update_board(king,[0,2])
    end
end

end


