require_relative "generic_moves"
require "pry-byebug"
class Bishop
    attr_accessor :current_position, :previous_position, :color
include GenericMoves
    def initialize
        @current_position = nil 
        @previous_position = nil 
        @color = nil 
    end

    def set_color(color)
        @color = color 
    end

    def set_position(position)
        if(@previous_position.nil?)
            @current_position = position 
        else 
            @previous_position = @current_position 
            @current_position = position 
        end
    end

    def valid_move?(board_state,input)
        if(valid_input(board_state,input))
        legal_moves = available_moves(board_state)
        #binding.pry
        return valid_move(input,legal_moves)
        else 
            return false 
        end
    end

    def available_moves(board_state)
        legal_moves = []
        legal_moves.concat(self.diagonal_moves_left(board_state,self))
        legal_moves.concat(self.diagonal_moves_right(board_state,self))
        return legal_moves 
    end

    def valid_input(board_state,input)
        if((0..board_state.length).include?(input[0]) && (0..board_state[input[0]].length).include?(input[1]))
            return true
        else 
            return false
        end
    end

    def valid_move(input,legal_moves)
        legal_moves.each do |legal_move|
            if(input == legal_move)
                return true 
            end
        end
        return false
    end
end