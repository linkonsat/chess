# frozen_string_literal: true

require 'pry-byebug'
module GenericMoves
  def vertical_moves(board_state, piece)
    valid_vertical_moves = []
    start_row_up = piece.current_position[0] + 1
    start_row_down = piece.current_position[0] - 1
    start_collumn = piece.current_position[1]
    until start_row_up > board_state[0].length - 1
      if board_state[start_row_up][start_collumn].respond_to?(:color) && board_state[start_row_up][start_collumn].color == piece.color
        break
      end

      valid_vertical_moves.push([start_row_up, start_collumn])
      if board_state[start_row_up][start_collumn].respond_to?(:color) && board_state[start_row_up][start_collumn].color != piece.color
        break
      end

      start_row_up += 1
    end
    until start_row_down < 0

      if board_state[start_row_down][start_collumn].respond_to?(:color) && board_state[start_row_down][start_collumn].color == piece.color
        break
      end

      valid_vertical_moves.push([start_row_down, start_collumn])
      if board_state[start_row_down][start_collumn].respond_to?(:color) && board_state[start_row_down][start_collumn].color != piece.color
        break
      end

      start_row_down -= 1
    end

    valid_vertical_moves
  end

  def horizontal_moves(board_state, piece)
    valid_horizontal_moves = []
    start_vertical = piece.current_position[0]
    start_collumn_left = piece.current_position[1] - 1
    start_collumn_right = piece.current_position[1] + 1
    until start_collumn_left < 0
      if start_collumn_left == 2
      end
      if board_state[start_vertical][start_collumn_left].respond_to?(:color) && board_state[start_vertical][start_collumn_left].color == piece.color
        break
      end

      valid_horizontal_moves.push([start_vertical, start_collumn_left])
      if board_state[start_vertical][start_collumn_left].respond_to?(:color) && board_state[start_vertical][start_collumn_left].color != piece.color
        break
      end

      start_collumn_left -= 1
    end
    until start_collumn_right > board_state[start_vertical].length - 1
      if board_state[start_vertical][start_collumn_right].respond_to?(:color) && board_state[start_vertical][start_collumn_right].color == piece.color
        break
      end

      valid_horizontal_moves.push([start_vertical, start_collumn_right])
      if board_state[start_vertical][start_collumn_right].respond_to?(:color) && board_state[start_vertical][start_collumn_right].color != piece.color
        break
      end

      start_collumn_right += 1
    end
    valid_horizontal_moves
  end

  def diagonal_moves_right(board_state, piece)
    valid_diagonal_moves = []
    start_row_up = piece.current_position[0] - 1
    start_row_down = piece.current_position[0] + 1
    start_collumn_up = piece.current_position[1] + 1
    start_collumn_down = piece.current_position[1] + 1
    until start_row_up < 0 || start_collumn_up > 7
      if board_state[start_row_up][start_collumn_up].respond_to?(:color) && board_state[start_row_up][start_collumn_up].color == piece.color
        break
      end

      valid_diagonal_moves.push([start_row_up, start_collumn_up])
      if board_state[start_row_up][start_collumn_up].respond_to?(:color) && board_state[start_row_up][start_collumn_up].color != piece.color
        break
      end

      start_row_up -= 1
      start_collumn_up += 1

    end
    until start_row_down > board_state[0].length - 1
      if board_state[start_row_down][start_collumn_down].nil?
      end
      if board_state[start_row_down][start_collumn_down].respond_to?(:color) && board_state[start_row_down][start_collumn_down].color == piece.color
        break
      end

      valid_diagonal_moves.push([start_row_down, start_collumn_down])
      if board_state[start_row_down][start_collumn_down].respond_to?(:color) && board_state[start_row_down][start_collumn_down].color != piece.color
        break
      end

      start_row_down += 1
      start_collumn_down += 1
    end
    valid_diagonal_moves
  end

  def diagonal_moves_left(board_state, piece)
    valid_diagonal_moves = []
    start_row_up = piece.current_position[0] - 1
    start_row_down = piece.current_position[0] + 1
    start_collumn_up = piece.current_position[1] - 1
    start_collumn_down = piece.current_position[1] - 1
    until start_row_up < 0 || start_collumn_up > 7
      if board_state[start_row_up][start_collumn_up].respond_to?(:color) && board_state[start_row_up][start_collumn_up].color == piece.color
        break
      end

      valid_diagonal_moves.push([start_row_up, start_collumn_up])
      if board_state[start_row_up][start_collumn_up].respond_to?(:color) && board_state[start_row_up][start_collumn_up].color != piece.color
        break
      end

      start_row_up -= 1
      start_collumn_up -= 1
    end
    until start_row_down > board_state[0].length - 1
      if board_state[start_row_down][start_collumn_down].respond_to?(:color) && board_state[start_row_down][start_collumn_down].color == piece.color
        break
      end

      valid_diagonal_moves.push([start_row_down, start_collumn_down])
      if board_state[start_row_down][start_collumn_down].respond_to?(:color) && board_state[start_row_down][start_collumn_down].color != piece.color
        break
      end

      start_row_down += 1
      start_collumn_down -= 1
    end
    valid_diagonal_moves
  end
end
