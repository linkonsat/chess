require "pry-byebug"
require_relative "./generic_moves"
class Rook 
    attr_accessor :color, :current_position, :previous_position
include GenericMoves
    def initialize
        @color = nil 
        @current_position = nil 
        @previous_position = nil 
    end

    def set_color(selected_color)
        @color = selected_color 
    end

    def set_position(current_position)
        if(@current_position.nil?)
            @current_position = current_position 
        else 
            @previous_postion = current_position
            @current_position = current_position 
        end 
    end

    def valid_move?(board_state,input)
        if(verify_input?(board_state,input))
        found_moves = legal_moves(board_state)
        return matches_input?(found_moves,input)
        else 
            puts "Value entered is not within range of the board row"
            return false
        end
    end

    def legal_moves(board_state)
        found_moves = []
        found_moves.concat(self.vertical_moves(board_state,self))
        found_moves.concat(self.horizontal_moves(board_state,self))
        return found_moves
    end


    def generate_symbol
        if(self.color == "black")
            return " ♜ "
        elsif(self.color == "white")
            return " ♖ "
        end
    end


    def matches_input?(legal_moves,input)
     
        legal_moves.each do |board_cell| 
            if(board_cell == input)
                return true 
            end
        end
        return false 
    end

    def verify_input?(board_state,input)
        
        if((0..board_state[0].length).include?(input[0]) && (0..board_state[0].length).include?(input[1]))
            return true 
        else 
            return false
        end
    end
end