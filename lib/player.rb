require_relative "game_messages"
class Player 
include GameMessages
    attr_accessor :color, 
    def initialize
        @color = nil 
    end

    def set_color(sets)
        self.color_selection(sets[0][0].color,sets[1][0].color)
        choice = gets.chomp 
        @color = sets[choice.to_i][0].color
    end
end