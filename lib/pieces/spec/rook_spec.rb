require_relative "../rook"


describe Rook do 

    #tests should describe it going horizontally and haiving it stopping at the piece
    #test should describe it not being able to move past piece
    #test should return true upon a castling move
    describe "#valid_move?" do 
    subject(:rook) {described_class.new}


    it "Allows a valid move up to one space before a allied piece" do 
        board = double("Board",:board => Array.new(8) {Array.new(8, "[]")})
        ally_piece = double("AllyPiece", :color => "black")
        board.board[4][4] = rook 
        board.board[4][4].set_position([4,4])
        board.board[4][2] = ally_piece
        board.board[4][4].set_color("black")
        expect(board.board[4][4].valid_move?(board.board,[4,2])).to eql(false)
        expect(board.board[4][4].valid_move?(board.board,[4,3])).to eql(true)
    end
    
    it "Allows a valid move up to a enemy piece" do 
        board = double("Board", :board => Array.new(8) {Array.new(8,"[]")})
        enemy_piece = double("EnemyPiece", :color => "purple")
        board.board[4][4] = rook
        board.board[4][4].set_position([4,4])
        board.board[4][1] = enemy_piece
        board.board[4][4].set_color("black")
        expect(board.board[4][4].valid_move?(board.board,[4,0])).to eql(false)
        expect(board.board[4][4].valid_move?(board.board,[4,1])).to eql(true)
    end

    it "Returns false on a invalid move direction" do 
        board = double("Board", :board => Array.new(8) {Array.new(8, "[]")})
 
        board.board[4][4] = rook 
        board.board[4][4].set_position([4,4])
        expect(board.board[4][4].valid_move?(board.board,[99,99])).to eql(false)
    end

    it "Allows a valid move to the end of the board state when unblocked" do 
        board = double("Board", :board => Array.new(8) {Array.new(8, "[]")})
        board.board[4][4] = rook 
        board.board[4][4].color = "black"
        board.board[4][4].set_position([4,4])
        expect(board.board[4][4].valid_move?(board.board,[4,0])).to eql(true)
        expect(board.board[4][4].valid_move?(board.board,[1,4])).to eql(true)
        expect(board.board[4][4].valid_move?(board.board,[7,4])).to eql(true)
        expect(board.board[4][4].valid_move?(board.board,[4,7])).to eql(true)
    end

   
end

end