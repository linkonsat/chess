require_relative "../main_game"
require_relative "../game"
require "pry-byebug"
describe MainGame do 
    describe "#main_interface" do 
    subject(:main_interface) {described_class.new}
    before do 
        allow(Dir).to receive(:exist?).and_return(true)
        allow(File).to receive(:exist?).and_return(true)
        allow(File).to receive(:open)
    end
    it "Tells the game object to load a saved game if requested" do 
        allow(main_interface).to receive(:gets).and_return("load")
        allow(main_interface.game).to receive(:load).and_return(true)
        expect(main_interface.game).to receive(:load_saved_game).once
        main_interface.main_menu
    end
    it "Sends a message to game to start a new game if requested" do 
        allow(main_interface).to receive(:gets).and_return("new")
        allow(main_interface.game).to receive(:game_run).and_return(true)
        expect(main_interface.game).to receive(:game_run).once
        main_interface.main_menu
    end
    it "Calls itself again if wrong input is entered" do 
        game = instance_double("Game")
        allow(main_interface).to receive(:gets).and_return("Random","Exit")
        expect(File).not_to receive(:open)
        expect(main_interface.game).not_to receive(:game_run)
        main_interface.main_menu
    end

end
end