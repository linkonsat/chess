require_relative "game_messages"
require "pry-byebug"
class Player 
include GameMessages
    attr_accessor :color, :choice
    def initialize
        @color = nil 
    end

    def set_color(sets)
        choice = gets.chomp 
        @color = sets[choice.to_i][0][0].color
    end

    def select_piece(board_state)
        self.select_piece_valid
        selected_position = gets.chomp
        if(selected_position == "save" || selected_position == "resignation")
            return selected_position
        end
        until  in_board?(selected_position,board_state) && right_piece?(selected_position, board_state)
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

    def in_board?(input,board_state)
        if((0..board_state.length).include?(input[0].to_i) && (0..board_state[input[0].to_i].length).include?(input[1].to_i))
            return true 
        else
            return false
        end
    end

    def right_piece?(input,board_state)
        if(board_state[input[0].to_i][input[1].to_i].class != String && board_state[input[0].to_i][input[1].to_i].color == self.color)
            return true
        else
            return false 
        end
    end

    def select_move(board_state) 
    input = gets.chomp 
    until in_board?(input,board_state) && input.length == 2 && right_piece?(input,board_state)
    end
        return input
end
end