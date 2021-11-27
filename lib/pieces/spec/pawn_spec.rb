require "pry-byebug"
require_relative "../pawn"
describe Pawn do 

    describe "#valid_move?"  do 
    subject(:pawn) {described_class.new}
        it "Returns true on valid move." do 
            board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
            board.board[1][0] = pawn
            valid_move =  board.board[1][0].valid_move?([2,0])
            expect(valid_move).to eql(true)
        end


        it "Enables 2 moves only once" do 
            board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
            board.board[6][0] = pawn
            board.board[6][0].legal_moves(board.board)
            pawn.update_position([6,0])
            board.board[4][0] = board.board[6][0]
            board.board[4][0].update_position([4,0])
            board.board[4][0].legal_moves(board.board)
            expect(board.board[4][0].default_moves).to eql([[-1,0]])
        end

end

    describe "#passant?" do 
    subject(:pawn) {described_class.new}
    it "Allows passant on pawn moves previous moving being two squares" do 
        board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
        board.board[1][0] = pawn
        board.board[3][1] = pawn
        board.board[1][0].valid_move?([2,0])
        expect(board.board[3][1].valid_move?([1,0])).to eql(true)
    end
end

    
    describe "#in_board?" do 
    subject(:pawn) {described_class.new}
    it "Only accepts input within the board range" do 
        board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
        board.board[1][0] = pawn 
        valid_move = board.board[1][0].valid_move?([99,0])
        expect(valid_move).to eql(false)
    end
end

    describe "#legal_moves" do 
    subject(:pawn) {described_class.new}
    it "gives pawns that start on the top side of the board positive moves" do 
        board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
        board.board[1][0] = pawn
        board.board[1][0].legal_moves(board.board)
        moves = board.board[1][0].default_moves
        expect(moves).to eql([[1,0],[2,0]])
    end

    it "gives pawns that start on the bottom side of the board negative moves" do 
        board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
        board.board[6][0] = pawn
        board.board[6][0].legal_moves(board.board)
        moves = board.board[6][0].default_moves
        expect(moves).to eql([[-1,0],[-2,0]])
    end
end

    describe "#set_color" do 
    subject(:pawn) {described_class.new}
    it "Gives pawn the entered color" do 
    board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
    board.board[1][0] = pawn
    board.board[1][0].set_color("black")
    expect(board.board[1][0].color).to eql("black")
    end
end

end