require_relative "../king"

describe King do 
#test should describe a valid move? Any move is valid so long as it is not off board and does NOT go into check
#King also can perform a castling move

    describe "#valid_move?" do 
    subject(:king) { described_class.new }
    it "Allows valid moves in any square around it." do 
        board = double("Board", :board => Array.new(8) { Array.new(8, "[]") })
        board.board[4][4] = king 
        board.board[4][4].set_position([4,4])
        expect(board.board[4][4].valid_move?(board.board,[4,3]))
    end
    it "Does not allow valid moves outside of the board." do 
        board = double("Board", :board => Array.new(8) { Array.new(8, "[]") })
        board.board[0][0] = king
        board.board[0][0].set_position([0,0])
        board.board[0][0].valid_move?(board.board,[99,99])
    end 
end

    describe "#castleing_available?" do 
    subject(:king) { described_class.new }
    it "Allows casteling when the king or spaces are not under check." do 
        board = double("Board", :board => Array.new(8) { Array.new(8, "[]" )})
        rook = double("Rook", :color => 'black' )
        board.board[0][4] = king 
        board.board[7][4] = king 
        board.board[0][0] = rook
        board.board[7][7] = rook
        board.board[0][4].color = "black"
        board.board[7][4].color = "black"
        expect([0][4].valid_move?(board.board,[0,2])).to eql(true)
        expect([7][4].valid_move?(board.board),[7,6]).to eql(true)

    end
    it "Does not allow casteling when the king or spaces between casteling are under check" do
        board = double("Board", :board => Array.new(8) { Array.new(8, "[]")}) 
        rook = double("Rook", :color => "black")
        enemy_rook = double("Rook", :valid_move? => [[0,4],[0,3],[0,2]])
        board.board[0][4] = king 
        board.board[0][0] = enemy_rook
        expect(board.board[0][4].valid_move?(board.board,[0,2])).to eql(false)
    end

    describe "#in_check?" do 
    subject(:king) { described_class.new }
        it "Does not allow king to move itself into check" do 
            board = double("Board", :board => Array.new(8) { Array.new(8, "[]") })
            pawn = double("Pawn", :valid_move => [1,0])
            board.board[0][0] = king
            board.board[2][1] = pawn
            expect(board.board[0][0].valid_move?(board.board,[1][0])).to eql(false)
        end
        it "Does not allow king to move itself into check" do 
            board = double("Board", :board => Array.new(8) { Array.new(8, "[]") })
            pawn = double("Pawn", :valid_move => [0,0])
            board.board[0][0] = king
            board.board[1][1] = pawn
            expect(board.board[0][0].in_check?(board.board,[0,0])).to eql(true)
        end
    end
end
end