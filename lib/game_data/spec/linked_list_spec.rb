require "../linked_list"
require "pry-byebug"
describe GameHistory do 

    describe "#tail" do 
    subject(:game_history) {described_class.new}
    it "Returns the last node in the list." do 
        game_board = double("GameBoard", :board => Array.new(8) {Array.new(8, "[]")})
        game_board_new = double("GameBoard", :board => Array.new(8) {Array.new(8, ":D")})
        game_history.insert(game_board.board)
        game_history.insert(game_board_new.board)
        expect(game_history.tail).to eql(game_board_new.board)
    end
end
describe "#head" do 
    subject(:game_history) {described_class.new}
    it "Returns the first node in the list." do 
        game_board = double("GameBoard", :board => Array.new(8) {Array.new(8, "[]")})
        game_board_new = double("GameBoard", :board => Array.new(8) {Array.new(8, ":D")})
        game_history.insert(game_board.board)
        game_history.insert(game_board_new.board)
        expect(game_history.head).to eql(game_board.board)
    end
end
    describe "#insert_node" do 
    subject(:game_history) {described_class.new}
    it "Inserts new game data at when added" do 
        game_board = double("GameBoard", :board => Array.new(8) {Array.new(8, "[]")})
        game_board_new = double("GameBoard", :board => Array.new(8) {Array.new(8, ":D")})
        game_history.insert(game_board.board)
        game_history.insert(game_board_new.board)
        expect(game_history.tail).to eql(game_board_new.board)
        expect(game_history.head).to eql(game_board.board)
    end 

    it "Inserts a new game data and gets rid of of old history when rewinded" do 
        game_board = double("GameBoard", :board => Array.new(8) {Array.new(8, "[]")})
        game_board_old = double("GameBoard", :board => Array.new(8) {Array.new(8, "old")})
        game_board_new = double("GameBoard", :board => Array.new(8) {Array.new(8, "new_tail")})
        game_history.insert(game_board.board)
        game_history.insert(game_board_old.board)
        expect(game_history.tail).to eql(game_board_old.board)
        game_history.insert(game_board_new)
        expect(game_history.tail).to eql(game_board_new.board)
    end 

end
    describe "#return_history" do 
    subject(:game_history) {described_class.new}
    it "allows returns previous node when rewind is entered" do 
        game_board = double("GameBoard", :board => Array.new(8) {Array.new(8, "[]")})
        game_board_old = double("GameBoard", :board => Array.new(8) {Array.new(8, ":D")})
        game_history.insert(game_board.board)
        game_history.insert(game_board_old.board)
        expect(game_history.rewind).to eql(game_board.board)
    end
    it "Returns node up to or less than the amount of requested nodes entered" do 
        game_board = double("GameBoard", :board => Array.new(8) {Array.new(8, "[]")})
        15.times do 
            game_history.insert(game_board.board)
        end
        retrieved_history = game_history.return_history(10)
        expect(retrieved_history.length).to eql(10)
        expect(retrieved_history.all?(game_board)).to eql(true)
    end

    it "Does not throw an error when requested history goes beyond list length" do 
        game_board = double("GameBoard", :board => Array.new(8) {Array.new(8, "[]")})
        5.times do 
            game_history.insert(game_board.board)
        end
        retrieved_history = game_history.return_history(10)
        expect(retrieved_history.length).to eql(5)
        expect(retrieved_history.all?(game_board)).to eql(true)
    end

end
end