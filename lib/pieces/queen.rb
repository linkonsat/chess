require_relative "generic_moves.rb"
require "pry-byebug"
class Queen 
    attr_accessor :current_position, :color, :previous_position
include GenericMoves
    def initialize
        @current_position = nil 
        @color = nil
        @previous_position = nil
    end
    def set_position(position)
        if(@current_position.nil?)
            @current_position = position
        else
            @previous_position = @current_position
            @current_position = position
        end
    end

    def set_color(color)
        @color = color 
    end
    def valid_move?(board_state,input)
        if(valid_input?(board_state,input))
            any_moves = legal_moves(board_state)
            return valid_move(any_moves,input)
        else
            return false
        end
    end

    def generate_symbol
        if(self.color == "black")
            return "♛"
        elsif(self.color == "white")
            return "♕"
        end
    end

    def valid_input?(board_state,input)
        if((0..board_state.length - 1).include?(input[0]) && (0..board_state[input[0]].length - 1).include?(input[1]))
            return true 
        else
            return false
        end
    end

    def legal_moves(board_state)
        valid_moves = []
        valid_moves.concat(self.vertical_moves(board_state,self))
        valid_moves.concat(self.horizontal_moves(board_state,self))
        valid_moves.concat(self.diagonal_moves_left(board_state,self))
        valid_moves.concat(self.diagonal_moves_right(board_state,self))
        return valid_moves
    end

    def valid_move(legal_moves,input)
        legal_moves.each do |legal_move|
            if(input == legal_move)
                return true     
            end
        end
        return false 
    end
end