require_relative "../main_game"
require_relative "../game"
describe MainGame do 
    describe "#main_interface" do 
    subject(:main_interface) {described_class.new}
    before do 
        allow(Dir).to receive(:exist?).and_return(true)
        allow(File).to receive(:open)
    end
    it "Tells the game object to load a saved game if requested" do 
        allow(main_interface).to receive(:gets).and_return("load")
        expect(File).to receive(:open).once
    end
    it "Sends a message to game to start a new game if requested" do 
        game = instance_double("Game")
        allow(main_interface).to receive(:gets).and_return("new")
        expect(game).to receive(:game_run).once
    end
    it "Throws a error if input does not match any of the options" do 
        game = instance_double("Game")
        allow(main_interface).to receive(:gets).and_return("Random")
        expect(File).not_to receive(:open)
        expect(game).not_to receive(:game_run)
    end
end
end