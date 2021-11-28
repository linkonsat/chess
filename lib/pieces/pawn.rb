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
        if(@default_moves[0][0] < 0)
            is_blocked_backward(board_state)
        elsif(@default_moves[0][0] > 0)
            is_blocked_forward(board_state)
        end
        if(@default_moves[0][0] > 0)
            is_attackable_forward(board_state)
        elsif(@default_moves[0][0] < 0)
            is_attackable_backward(board_state)
        end
        return @available_move_values
    end

    def update_position(new_coordinates)
        @previous_position = @current_position 
        @current_position = new_coordinates
    end

    def initial_moves(board_state)
        if (board_state[1].include?(self) )
            @default_moves = [[1,0],[2,0]]
        elsif (board_state[6].include?(self))
            @default_moves = [[-1,0],[-2,0]]
        end
        @available_move_values.push(default_moves[0],default_moves[1])
    end
    private
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

    def is_blocked_forward(board_state)
        found_moves = []
        available_moves = 0
        board_state[current_position[0]][current_position[1]]
        position = 0
        i = 1
        new_row_coordinate = current_position[0] + i
        binding.pry
        until board_state[new_row_coordinate][current_position[1]] != "[]" || i == 3
            found_moves.push(@default_moves[position])
            i += 1
            position += 1
            new_row_coordinate = current_position[0] + 1
        end

        remove_duplicates(found_moves)
    end

    def is_blocked_backward(board_state)
        found_moves = []
        available_moves = 0
        board_state[current_position[0]][current_position[1]]
        position = 0
        i = 1
        new_row_coordinate = current_position[0] - i
        until board_state[new_row_coordinate][current_position[1]] != "[]" || i == 3
            found_moves.push(@default_moves[position])
            i += 1
            position += 1
            new_row_coordinate = current_position[0] - i
        end
        remove_duplicates(found_moves)
    end

    def is_attackable_forward(board_state)
        attackable_positions = []
        left_move = @current_position[1] + 1
        forward_move = @current_position[0] + 1
        right_move = @current_position[1] - 1
        if (board_state[forward_move][left_move] != "[]")
            attackable_positions.push([forward_move,left_move])
        end

        if (board_state[forward_move][right_move] != "[]")
            attackable_positions.push([forward_move,right_move])
        end
        remove_duplicates(attackable_positions)
    end

    def is_attackable_backward(board_state)
        attackable_positions = []
        left_move = @current_position[1] + 1
        forward_move = @current_position[0] - 1
        right_move = @current_position[1] - 1
        if (board_state[forward_move][left_move] != "[]")
            attackable_positions.push([forward_move,left_move])
        end

        if (board_state[forward_move][right_move] != "[]")
            attackable_positions.push([forward_move,right_move])
        end
        remove_duplicates(attackable_positions)
    end
    def remove_duplicates(found_moves)
       found_moves.each do |item|  
        if(!@available_move_values.include?(item) && item != nil)
        @available_move_values.push(item)
        end
    end
    end
end