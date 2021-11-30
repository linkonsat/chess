
require "pry-byebug"
class King

    attr_accessor :color, :current_position, :previous_position, :available_moves_values

    def initialize
        @color = nil
        @current_position = nil 
        @previous_position = nil
        @available_move_values = nil
    end

    def set_color(color)
        @color = color
    end

    def set_position(position) 
        if(@current_position == nil)
            @current_position = position
        else
            @previous_position = @current_position
            @current_position = position 
        end
    end

    def valid_move?(board_state,input) 
        legal_moves = any_moves?(board_state)
        validate_input(legal_moves,input)
    end

    def legal_moves(board_state)
        @available_move_values = []
        #so now we want to get the current board position as a reference to our moves
        @available_move_values.push(any_moves?(board_state))
    end

    def any_moves?(board_state)
        #so a move can be one of three ways. the way we could test this is by checking the vertical sides then the middle side
        found_moves = []
        found_moves_left = left_vertical_moves(board_state)
        found_moves_left.each { |item| found_moves.push(item) }
        found_moves_right = right_vertical_moves(board_state)
        found_moves_right.each { |item| found_moves.push(item) }
        found_moves_top = top_move(board_state)
        found_moves_top.each { |item| found_moves.push(item)}
        found_moves_bottom = bottom_move(board_state)
        found_moves_bottom.each { |item| found_moves.push(item) }
        return found_moves
    end

    def left_vertical_moves(board_state)
        if((0..board_state[current_position[0]].length).include?(current_position[1] - 1))   
            
           return [[current_position[0] - 1,current_position[1] - 1], [current_position[0], current_position[1] - 1], [current_position[0] + 1, current_position[1] - 1]]
        end
    end

    def right_vertical_moves(board_state)
        if ((0..board_state[current_position[0]].length).include?(current_position[1] + 1))
            return [[current_position[0],current_position[1] + 1], [current_position[0] + 1, current_position[1] + 1], [current_position[0] - 1, current_position[1] + 1]]
        end
    end

    def top_move(board_state) 
            if ((0..board_state[current_position[0] + 1].length).include?(current_position[1] + 1))
               return [[current_position[0] + 1,current_position[1]]]
            end
    end

    def bottom_move(board_state)
       if ((0..board_state[current_position[0] - 1].length).include?(current_position[1] - 1))
            return [[current_position[0] + 1, current_position[1]]]
       end
    end

    def validate_input(found_moves,input)
        found_moves.each do |item|
            horizontal = 0
            vertical = 1
            if(self.current_position[0] + item[horizontal] == input[0] || self.current_position[0] - item[horizontal] == input[0] && self.current_position[1] + item[vertical] == input[1] || self.current_position[1] - item[1] == input[1])
            binding.pry
            return true
            end
        return false
        end
    end
end