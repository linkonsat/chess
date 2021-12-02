module GenericMoves
    def horizontal_moves
        #set up a variable to hold the found values
valid_horizontal_moves = []
#set a loop starting from from the current position with an end condition of either there is an enemy piece, friendly piece or eob
start_row_up = piece.current_position[0]
start_row_down = piece.current_position[0]
start_collumn = piece.current_position[1]
until start_row_up > board_state[0].length || board_state[start_row_up][start_collumn].color == piece.color || board_state[start_row_up][start_column] != "[]"
valid_horizontal_moves.push([start_row,start_collumn])
start_row_up += 1
end
until start_row_down < board_state[0].length || board_state[start_row_down][start_collumn].color == piece.color || board_state[start_row_down][start_column] != "[]"
valid_horizontal_moves.push([start_row_down,start_column])
start_row_down
end
return valid_horizontal_moves
    end

    def vertical_moves

    end

    def diagonal_moves

    end
end