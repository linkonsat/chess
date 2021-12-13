require_relative "../player"

describe Player do 
#really all we need to test is that given a set of colored pieces the correct color is chose and when a piece is selected that the proper item has been chosen
    describe "#set_color" do 
    subject(:player) {described_class.new}
    it "Sets the correct color given a predefined set of pieces" do 
    piece = double("Pawn", :color => "Black")
    piece_two = double("Rook", :color => "White")
    sets = [[piece],[piece_two]]
    allow(player).to receive(:gets).and_return(1)
    player.set_color(sets)
    expect(player.color).to eql("White")
    end
    describe "#select_piece" do 
    subject(:player) {described_class.new} 
    it "Returns the piece if selected input does not equal a string." do 
        board = double("Board", :board => Array.new(8) {Array.new(8,"[]")})
        pawn = double("Pawn")
        board.board[0][0] = pawn
        selected_piece = player.select_piece("00",board.board)
        expect(selected_piece).to eql(pawn)
    end
    it "Returns error message if piece is not selected on the board" do 
        board = double("Board", :board => Array.new(8) {Array.new(8,"[]")})
        pawn = double("Pawn")
        board.board[0][0] = pawn
        allow(player).to receive(:player_input).and_return("990","00")
        allow(player).to receive(:board_state).with(board.board,board.board)
        expect(subject).to receive(:game_messages).with("Error! Selected a non-existent board spot.").once
    end
    it "Returns error message if piece is not a chess piece." do 
        board = double("Board", :board => Array.new(8) {Array.new(8,"[]")})
        pawn = double("Pawn")
        board.board[0][0] = pawn
        allow(player).to receive(:player_input).and_return("05","00")
        allow(player).to receive(:board_state).with(board.board,board.board)
        expect(subject).to receive(:game_messages).with("Error! Selected a board cell that does not contain a piece.").once 
    end
end
end