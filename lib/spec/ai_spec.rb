#AI gathers all of its pieces, should then select a pice
#After ai selects a piece will keep in put random numbers until a valid move is selected and then returns said value 
#AI also selects a random color or can be assigned a color if non is given through set color
require_relative "../ai"
describe AI do 

    describe "#piece_moves" do 
    subject(:ai) {described_class.new}
    it "Selects a pieces legal moves on the board." do 
        pawn = double("PawnSecond", :color => "black", :legal_moves => [1,1])
        expect(ai.piece_moves([pawn])).to eql([[1,1]])
    end
    it "Selects multiple pieces legal moves on the board." do 
        pawn = double("PawnSecond", :color => "black", :legal_moves => [1,1])
        expect(ai.piece_moves([pawn,pawn])).to eql([[1,1],[1,1]])
    end
end
#move choice calls all the pieces it owns on the board. after calling it. it goes one at a time and if a piece has legal moves and returns a valid move
    describe "#move_choice" do 
    subject(:ai) {described_class.new}
    it "Finds the matching pieces on the board and returns false and moves to another piece if there are no legal moves." do 
        board = double("Board", :board => Array.new(8) {Array.new(8,"[]")})
        pawn = double("Pawn", :color => "black", :legal_moves => [])
        pawn_second = double("PawnSecond", :color => "black", :legal_moves => [1,1], :valid_move? => true)
        board.board[0][0] = pawn
        board.board[0][1] = pawn_second
        expect(ai.move_choice(board.board)).to eql(true)
    end
    it "Calls valid method on the selected piece until true is returned and returns that value" do 
        board = double("Board", :board => Array.new(8) {Array.new(8,"[]")})
        pawn = double("Pawn", :color => "black", :valid_move? => true)
        board.board[0][0] = pawn
        expect(ai.move_choice(board.board)).to eql(true)
    end
    it "Returns false if no moves are available." do 
        board = double("Board", :board => Array.new(8) {Array.new(8,"[]")})
        pawn = double("Pawn", :color => "black", :legal_moves => [])
        board.board[0][0] = pawn
        expect(ai.move_choice(board.board)).to eql (false)
    end
    it "Returns false if none of the moves are valid." do 
        board = double("Board", :board => Array.new(8) {Array.new(8,"[]")})
        pawn = double("Pawn", :color => "black", :valid_move? => false)
        board.board[0][0] = pawn
        expect(ai.move_choice(board.board)).to eql (false)
    end
end

    describe "#select_color" do 
    subject(:ai) {described_class.new}
    it "Selects a random color from the predefined sets available on the board." do 
        board = double("Board", :board => Array.new(8) {Array.new(8,"[]")})
        pawn = double("Pawn", :color => "black")
        second_pawn = double("PawnNew", :color => "white")
        board.board[0][0] = pawn
        board.board[7][0] = second_pawn
        found_colors = ai.select_color(board.board)
        expect(["white","black"]).to include(found_colors)
    end
    it "Assigns a color if a color is passed through a parameter" do 
        ai.select_color("white")
        expect(ai.color).to eql("white")
    end
end

end