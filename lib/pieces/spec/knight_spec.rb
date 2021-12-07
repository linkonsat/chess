require_relative "../knight"
describe Knight do 
describe "#valid_move?" do 
subject(:knight) {described_class.new}

    it "Returns false on input outside of the board." do 
    board = double("Board", :board => Array.new(8) {Array.new(8, "| |")})
    board.board[4][4] = knight 
    board.board[4][4].set_color("black")
    board.board[4][4].set_position([4,4])
    expect(board.board[4][4].valid_move?(board.board,[2,99])).to eql(false)
    end
    it "Returns false on a board spot occupied by a friendly piece." do 
    board = double("Board", :board => Array.new(8) {Array.new(8, "| |")})
    friendly = double("AllyPiece", :color => "black")
    board.board[4][4] = knight 
    board.board[5][6] = friendly
    board.board[4][4].set_color("black")
    board.board[4][4].set_position([4,4])
    expect(board.board[4][4].valid_move?(board.board,[5,6])).to eql(false)
    end
    it "Returns true on a legal move on a empty board spot" do 
    board = double("Board", :board => Array.new(8) {Array.new(8, "| |")})
    board.board[4][4] = knight 
    board.board[4][4].set_color("black")
    board.board[4][4].set_position([4,4])
    expect(board.board[4][4].valid_move?(board.board,[5,6])).to eql(true)
    end

    it "Returns true on a legal move on a enemy piece" do
    board = double("Board", :board => Array.new(8) {Array.new(8, "| |")})
    enemy_piece = double("EnemyPiece", :color => "purple")
    board.board[4][4] = knight 
    board.board[5][6]= enemy_piece
    board.board[4][4].set_color("black")
    board.board[4][4].set_position([4,4])
    expect(board.board[4][4].valid_move?(board.board,[5,6])).to eql(true)
    end
end
end