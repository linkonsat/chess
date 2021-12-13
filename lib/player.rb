require_relative "game_messages"
require "pry-byebug"
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

    def select_piece(board_state)
        self.select_piece_valid
        selected_position = gets.chomp
        until (0..board_state.length).include?(selected_position[0].to_i) && (0..board_state[selected_position[0].to_i].length).include?(selected_position[1].to_i) && board_state[selected_position[0].to_i][selected_position[1].to_i].class != String && board_state[selected_position[0].to_i][selected_position[1].to_i].color == self.color
            if(selected_position.length != 2)
                self.outside_board
            elsif(board_state[selected_position[0].to_i].nil?)
                self.outside_board
            elsif(board_state[selected_position[0].to_i][selected_position[1].to_i].nil?) 
                self.outside_board
            elsif(board_state[selected_position[0].to_i][selected_position[1].to_i].class == String )
                self.invalid_board_cell
            end
            selected_position = gets.chomp
        end
        return board_state[selected_position[0].to_i][selected_position[1].to_i]
    end
end