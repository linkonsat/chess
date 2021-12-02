# frozen_string_literal: true

module GenericMoves
  def horizontal_moves(board_state, piece)
    # set up a variable to hold the found values
    valid_horizontal_moves = []
    # set a loop starting from from the current position with an end condition of either there is an enemy piece, friendly piece or eob
    start_row_up = piece.current_position[0]
    start_row_down = piece.current_position[0]
    start_collumn = piece.current_position[1]
    until start_row_up > board_state[0].length || board_state[start_row_up][start_collumn].color == piece.color || board_state[start_row_up][start_column] != '[]'
      valid_horizontal_moves.push([start_row, start_collumn])
      start_row_up += 1
    end
    until start_row_down < board_state[0].length || board_state[start_row_down][start_collumn].color == piece.color || board_state[start_row_down][start_column] != '[]'
      valid_horizontal_moves.push([start_row_down, start_column])
      start_row_down
    end
    valid_horizontal_moves
  end

  def diagonal_moves_right(board_state, piece)
    valid_diagonal_moves = []
    start_row_up = piece.current_position[0]
    start_row_down = piece.current_position[0]
    start_collumn_up = piece.current_position[1]
    start_collumn_down = piece.current_position[1]
    until start_row_up > board_state[0].length || board_state[start_row_up][start_collumn].color == piece.color || board_state[start_row_up][start_column] != '[]'
      valid_horizontal_moves.push([start_row, start_collumn])
      start_row_up -= 1
      start_collumn_up += 1
    end
    until start_row_down < board_state[0].length || board_state[start_row_down][start_collumn].color == piece.color || board_state[start_row_down][start_column] != '[]'
      valid_horizontal_moves.push([start_row_down, start_column])
      start_row_down += 1
      start_collumn_down += 1
    end
    valid_diagonal_moves
      end

  def diagonal_moves_left(board_state, piece)
    valid_diagonal_moves = []
    start_row_up = piece.current_position[0]
    start_row_down = piece.current_position[0]
    start_collumn_up = piece.current_position[1]
    start_collumn_down = piece.current_position[1]
    until start_row_up > board_state[0].length || board_state[start_row_up][start_collumn].color == piece.color || board_state[start_row_up][start_column] != '[]'
      valid_horizontal_moves.push([start_row, start_collumn])
      start_row_up -= 1
      start_collumn_up -= 1
    end
    until start_row_down < board_state[0].length || board_state[start_row_down][start_collumn].color == piece.color || board_state[start_row_down][start_column] != '[]'
      valid_horizontal_moves.push([start_row_down, start_column])
      start_row_down += 1
      start_collumn_down -= 1
    end
    valid_diagonal_moves
  end
end
