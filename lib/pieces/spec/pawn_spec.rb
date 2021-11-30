require "pry-byebug"
require_relative "../pawn"
describe Pawn do 


    describe "#passant?" do 
    subject(:pawn) {described_class.new}
    it "Allows passant on pawn moves previous moving being two squares forward" do 
        board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
        pawn_1 = pawn 
        pawn_2 = pawn 
        board.board[1][0] = pawn_1
        board.board[1][0].default_moves = [[1,0],[2,0]]
        board.board[1][0].update_position([1,0])
        board.board[3][1] = pawn_2 
        board.board[3][1].update_position([3,1])
        board.board[1][1] = board.board[3][1]
        board.board[1][1].update_position([1,1])
        expect(board.board[1][0].valid_move?(board.board,[2,1])).to eql(true)
    end


    it "Allows passant on pawn moves previous moving being two squares backward" do 
        board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
        pawn_1 = pawn 
        pawn_2 = pawn 
        board.board[3][0] = pawn_1
        board.board[3][0].default_moves = [[1,0],[2,0]]
        board.board[3][0].update_position([3,0])
        board.board[1][1] = pawn_2 
        board.board[1][1].update_position([1,1])
        board.board[3][1] = board.board[1][1]
        board.board[3][1].update_position([3,1])
        expect(board.board[3][1].valid_move?(board.board,[2,1])).to eql(true)
    end


end

    describe "#blocked?" do 
    subject(:pawn) {described_class.new}
    it "Does not allow pawn to move forward if there is a piece in front of it" do 
        board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
        board.board[1][0] = pawn 
        board.board[2][0] = pawn
        board.board[1][0].update_position([1,0])
        result = board.board[1][0].valid_move?(board.board,[3,0])

    end
end

    
    describe "#valid_move?"  do 
    subject(:pawn) {described_class.new}
    it "Enables 2 moves only once" do 
        board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
        board.board[6][0] = pawn
        pawn.initial_moves(board.board)
        pawn.update_position([6,0])
        board.board[6][0].valid_move?(board.board,[4,0])
        board.board[4][0] = board.board[6][0]
        board.board[4][0].update_position([4,0])
        valid_move = board.board[4][0].valid_move?(board.board,[0,0])
        expect(board.board[4][0].default_moves).to eql([[-1,0]])
    end

        it "Returns true on forward move." do 
            board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
            board.board[1][0] = pawn
            board.board[1][0].update_position([1,0])
            valid_move =  board.board[1][0].valid_move?(board.board,[2,0])
            expect(valid_move).to eql(true)
        end

        it "Returns true on backward steps" do 
            board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
            board.board[6][0] = pawn
            board.board[6][0].update_position([6,0])
            valid_move =  board.board[6][0].valid_move?(board.board,[5,0])
            expect(valid_move).to eql(true)
        end

end

    describe "#is_attackable_forward?" do 
    subject(:pawn) {described_class.new}
    it "Includes pieces within attack range as valid moves" do 
        board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
        board.board[1][0] = pawn 
        board.board[2][1] = pawn
        board.board[1][0].update_position([1,0])
        valid_move = board.board[1][0].valid_move?(board.board,[2,1])
        expect(valid_move).to eql(true)
    end
end

    describe "#is_attackable_backward?" do 
    subject(:pawn) {described_class.new}
    it "allows pieces to be attacked on pieces going backwards" do 
    end
end

    describe "#legal_moves" do 
    subject(:pawn) {described_class.new}
    it "gives pawns that start on the top side of the board positive moves" do 
        board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
        board.board[1][0] = pawn
        board.board[1][0].update_position([1,0])
        board.board[1][0].legal_moves(board.board)
        moves = board.board[1][0].default_moves
        expect(moves).to eql([[1,0],[2,0]])
    end

    it "gives pawns that start on the bottom side of the board negative moves" do 
        board = double("Board", :board => Array.new(8) { Array.new(8, "[]")})
        board.board[6][0] = pawn
        board.board[6][0].update_position([6,0])
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