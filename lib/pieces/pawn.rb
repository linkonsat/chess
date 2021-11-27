class Pawn
    attr_accessor :current_position, :previous_position, :color,:available_move_values, :default_moves

    def initialize(current_position = nil)
        @current_position = current_position
        @previous_position = nil
        @color = nil
        @available_move_values = []
        @default_moves = nil
    end

    
    def set_color(color) 
        @color = color 
    end

    def valid_move?(board_state,input) 
        validated_moves = legal_moves(board_state)
        if (forward_step(validated_moves,input) || backward_step(validated_moves,input))
            return true

        else
            return false
        end

    end

    def legal_moves(board_state)
        @available_move_values = []
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
        @available_move_values.push(default_moves[0],default_moves[1])
    end
    
    def two_step_available(board_state)
        if(self.default_moves.include?([-2,0]))
            if (previous_position[0] + -2 == current_position[0])
                @default_moves = [[-1,0]]
                @available_move_values.push(@default_moves[0])
            end
        elsif(self.default_moves.include?([2,0]))
            if (previous_position[0] + 2 == current_position[0])
                @default_moves = [[1,0]]
                @available_move_values.push(@default_moves[0])
            end
        else
            @available_move_values.push(@default_moves[0])
        end
    end

    def forward_step(validated_moves,input)
        move_value = current_position[0] - input[0]
        validated_moves.each do |item|
            if(item[0] == move_value)
            
                return true
            end
        end
        return false
    end
    def backward_step(validated_moves,input)
        move_value = input[0] - current_position[0]
        validated_moves.each do |item|
            if(item[0] == move_value)
                return true
            end
        end
        return false
    end

end