require_relative "game"
require "pry-byebug"
class MainGame 
    attr_accessor :game
    def initialize 
        @game = Game.new
    end

    def main_menu 
        choice = gets.chomp 
        if(choice == "load" && saved_game?)
            @game.load_saved_game
        elsif(choice == "new")
            @game.game_run
        elsif(choice == "Exit")
        else
            self.main_menu 
        end
    end

    def saved_game?
        if(File.exist?("./game_data/saved_game.rb"))
            return true 
        else
            return false 
        end
    end
end
