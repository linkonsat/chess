class Pawn
    attr_accessor :current_position, :previous_position, :color,:available_move_values, :default_moves

    def initialize(current_position = nil)
        @current_position = current_position
        @previous_position = nil
        @color = nil
        @available_move_values = nil
        @default_moves = nil
    end

    
    def set_color(color) 
        @color = color 
    end

    def valid_move?(board_state,input) 

    end

    def legal_moves(board_state)
        if(@previous_position == nil) 
        initial_moves(board_state)  
        else
            two_step_available(board_state)
        end
    end

    def update_position(new_coordinates)
        @previous_position = @current_position 
        @current_position = new_coordinates
    end
    private

    def initial_moves(board_state)
        if (board_state[1].include?(self) )
            @default_moves = [[1,0],[2,0]]
        elsif (board_state[6].include?(self))
            @default_moves = [[-1,0],[-2,0]]
        end
    end
    
    def two_step_available(board_state)
        if(self.default_moves.include?([-2,0]))
            if (previous_position[0] + -2 == current_position[0])
                @default_moves = [[-1,0]]
            end
        elsif(self.default_moves.include?([2,0]))
            if (previous_position[0] + 2 == current_position[0])
                @default_moves = [[1,0]]
            end
        end
    end

    def negative_step

    end

    def positive_step

    end
end