require_relative "../game"

#tests should cover round,conclusion,setup,

describe Game do 
    describe "#setup" do 
    subject(:game) {described_class.new}
    it "Sets up the accurate game instance variables" do 
        allow(game).to receive(:player_set_choice?).and_return(1)
        game.setup 
        expect(game.players).to eql(2)
        expect(game.board[0].all?(String)).to eql(false)
        expect(game.board[1].all?(String)).to eql(false)
        expect(game.board[6].all?(String)).to eql(false)
        expect(game.board[7].all?(String)).to eql(false)
        expect(game.fifty_move_rule_counter).to eql(0)
        expect(game.total_turns).to eql(0)
    end
end
    describe "#round" do 
    subject(:game) {described_class.new}
    it "Runs a game round sucessfully and" do 
        pawn = double("pawn")
        allow(game).to receive(:player_set_choice?).and_return(1)
        game.setup
        allow(game).to receive(:player_turn).and_return(game.player_list[0])
        allow(player).to receive(:select_piece).and_return(pawn)
        allow(player).to receive(:selected_player_move).and_return([5,5])
        expect(game.board.board[5][5]).to eql(pawn)
        expect(game.fifty_move_rule_counter).to eql(1)
    end
end

    describe "#player_turn" do 
    subject(:game) {described_class.new}
    it "Selects the correct player after the previous player has had their turn." do
    allow(game).to receive(:player_set_choice?).and_return(1)
    expect(game.player_turn).to eql(game.player_list[0])
end
end
    describe "#conclusion" do 
    subject(:game) {described_class.new}
    it "Starts a new game when Y is entered on the conclusion screen" do
    allow(game).to receive(:gets).and_return("Y")
    game.conclusion
    expect(game).to receive(:game)
end
it "Starts a new game when Y is entered on the conclusion screen" do
    allow(game).to receive(:gets).and_return("N")
    game.conclusion
    expect(game).not_to receive(:game)
end
end
end