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
        legal_moves = find_moves(board_state)
        matches_input?(legal_moves,input)
    end

    def find_moves(board_state)
        found_moves = []
        found_moves.concat(self.vertical_moves(board_state,self))
        found_moves.concat(self.horizontal_moves(board_state,self))
        return found_moves
    end

    def matches_input?(legal_moves,input)
        legal_moves.each do |board_cell| 
            if(board_cell == input)
                return true 
            end
        end
        return false 
    end
end