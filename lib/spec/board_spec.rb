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
    describe "#place_set" do 
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
        board.update_piece(new_coordinates)
        expect(board.board[5][5]).to eql(pawn)
    end
end

end


