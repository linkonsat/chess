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
       # binding.pry
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
            is_attackable_backward(board_state)
            passant_forward(board_state)
        elsif(@default_moves[0][0] > 0)
            is_blocked_forward(board_state)
            is_attackable_forward(board_state)
            passant_backward(board_state)
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

    def passant_forward(board_state) 
        attackable_pieces = []
        if ((0..board_state[self.current_position[0]].length).include?(self.current_position[1] + 1)  && board_state[self.current_position[0]][self.current_position[1] + 1].class != String )
        attackable_pieces.push(board_state[self.current_position[0]][self.current_position[1] + 1])

        end
        #issue is that logic path isnt pushing the piece
        #p board_state[self.current_position[0]][self.current_position[1] - 1] 
        if ((0..board_state[self.current_position[0]].length).include?(self.current_position[1] - 1) && board_state[self.current_position[0]][self.current_position[1] - 1].class != String)
        attackable_pieces.push(board_state[self.current_position[0]][self.current_position[1] - 1])
        end
        verify_passant_forward?(attackable_pieces)
    end

    def passant_backward(board_state)
        attackable_pieces = []
        if ((0..board_state[self.current_position[0]].length).include?(self.current_position[1] + 1) && board_state[self.current_position[0]][self.current_position[1] + 1].class != String)
        attackable_pieces.push(board_state[self.current_position[0]][self.current_position[1] + 1])
        end
        if ((0..board_state[self.current_position[0]].length).include?(self.current_position[1] - 1) && board_state[self.current_position[0]][self.current_position[1] - 1].class != String)
            attackable_pieces.push(board_state[self.current_position[0]][self.current_position[1] - 1])
        end
        verify_passant_backward?(attackable_pieces)
    end

    def verify_passant_forward?(found_pieces)
        #expect if found pieces contains a move set that indicates the last move was two steps it pushes those moves so
        #first we need to "loop through the found pieces since it can be more than one"
        
        found_pieces.each do |item|
            if (item != nil && item.current_position[0] - 2 == item.previous_position[0] && item.color != self.color)
                @available_moves_values.push([item.previous_position[0] + 1,item.previous_position[1]])
            end
        end
            
    end

    def verify_passant_backward?(found_pieces)
        found_pieces.each do |item|
            if (item != nil && item.current_position[0] + 2 == item.previous_position[0] && item.color != self.color)
                @available_move_values.push([item.previous_position[0] - 1, item.previous_position[1]])
            end
        end
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
        validated_moves.each do |item|
 
        vertical_move_value = current_position[0] + item[0]
        horizontal_move_left = current_position[1] - item[1]
        horizontal_move_right = current_position[1] + item[1]
           # binding.pry
        if(input[0] == vertical_move_value && input[1] == horizontal_move_left || input[1] == horizontal_move_right)
            return true
            end
        end
        return false
    end
    def backward_step(validated_moves,input)
        validated_moves.each do |item|
            #binding.pry
        vertical_move_value = current_position[0] - item[0]
        horizontal_move_left = current_position[1] - item[1]
        horizontal_move_right = current_position[1] + item[1] 
        if(input[0] == vertical_move_value && input[1] == horizontal_move_left || input[1] == horizontal_move_right)
            return true
            end
        end
        return false
    end

    def is_blocked_forward(board_state)
        available_moves = 0
        board_state[current_position[0]][current_position[1]]
        position = 0
        i = 1
        new_row_coordinate = current_position[0] + i
        until board_state[new_row_coordinate][current_position[1]].class != String || i - 1 == @default_moves.length
            available_moves += 1
            i += 1
            position += 1
            new_row_coordinate = current_position[0] + 1
        end
        remove_blocked_moves(available_moves)
    end

    def is_blocked_backward(board_state)
        available_moves = 0
        board_state[current_position[0]][current_position[1]]
        position = 0
        i = 1
        new_row_coordinate = current_position[0] - i
        until board_state[new_row_coordinate][current_position[1]].class != String || i - 1 == @default_moves.length
            available_moves += 1
            i += 1
            position += 1
            new_row_coordinate = current_position[0] - i
        end
        remove_blocked_moves(available_moves)
    end

        def remove_blocked_moves(unblocked_moves)
            if(unblocked_moves == 0)
                @available_move_values.delete_if { |item| @default_moves.any?(item)}
            elsif(unblocked_moves == 1)
                @available_move_values.delete_if { |item| item == @default_moves[1]}
            end
        end

    def is_attackable_forward(board_state)

        attackable_positions = []
        left_move = @current_position[1] + 1
        forward_move = @current_position[0] + 1
        right_move = @current_position[1] - 1
        if (board_state[forward_move][left_move].class != String && board_state[forward_move][left_move].color != self.color)
            attackable_positions.push([forward_move,left_move])
        end

        if (board_state[forward_move][right_move].class != String && board_state[forward_move][right_move].color != self.color)
            attackable_positions.push([forward_move,right_move])
        end
        remove_duplicates(attackable_positions)
    end

    def is_attackable_backward(board_state)
        attackable_positions = []
        left_move = @current_position[1] + 1
        forward_move = @current_position[0] - 1
        right_move = @current_position[1] - 1
        if (board_state[forward_move][left_move].class != String && board_state[forward_move][left_move].color != self.color)
            attackable_positions.push([forward_move,left_move])
        end

        if (board_state[forward_move][right_move].class != String && board_state[forward_move][right_move] != self.color)
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