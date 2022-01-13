# frozen_string_literal: true

require 'pry-byebug'
module MoveRules
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

  def left_vertical_moves(board_state)
    valid_verticals_left = []
    if (0..board_state[current_position[0]].length).include?(current_position[1] - 1)

      possible_moves = [[current_position[0] - 1, current_position[1] - 1],
                        [current_position[0], current_position[1] - 1], [current_position[0] + 1, current_position[1] - 1]]

      possible_moves.each do |position|
        unless (!board_state[position[0]].nil? && board_state[position[0]][position[1]].respond_to?(:color) && board_state[position[0]][position[1]].color != color) || (!board_state[position[0]].nil? && board_state[position[0]][position[1]].instance_of?(String))
          next
        end

        if (0..7).include?(position[0]) && (0..7).include?(position[1]) && !king_check?(board_state, position)
          valid_verticals_left.push(position)
        end
      end
    end
    valid_verticals_left
  end

  def right_vertical_moves(board_state)
    valid_verticals_right = []
    if (0..board_state[current_position[0]].length).include?(current_position[1] + 1)
      possible_moves = [[current_position[0], current_position[1] + 1],
                        [current_position[0] + 1, current_position[1] + 1], [current_position[0] - 1, current_position[1] + 1]]
      possible_moves.each do |position|
        unless (!board_state[position[0]].nil? && board_state[position[0]][position[1]].respond_to?(:color) && board_state[position[0]][position[1]].color != color) || (!board_state[position[0]].nil? && board_state[position[0]][position[1]].instance_of?(String))
          next
        end

        if (0..7).include?(position[0]) && (0..7).include?(position[1]) && !king_check?(board_state, position)
          valid_verticals_right.push(position)
        end
      end
    end
    # binding.pry
    valid_verticals_right
  end

  def top_move(board_state)
    if ((!board_state[current_position[0] + 1].nil? && board_state[current_position[0] + 1][current_position[1]].respond_to?(:color) && board_state[current_position[0] + 1][current_position[1]].color != color) || (!board_state[current_position[0] + 1].nil? && board_state[current_position[0] + 1][current_position[1]].instance_of?(String))) && ((0..7).include?(current_position[0] + 1) && !king_check?(board_state,
                                                                                                                                                                                                                                                                                                                                                                                                                       [
                                                                                                                                                                                                                                                                                                                                                                                                                         current_position[0] + 1, current_position[1]
                                                                                                                                                                                                                                                                                                                                                                                                                       ]))
      return [[current_position[0] + 1, current_position[1]]]
    end

    []
  end

  def bottom_move(board_state)
    if ((!board_state[current_position[0] - 1].nil? && board_state[current_position[0] - 1][current_position[1]].respond_to?(:color) && board_state[current_position[0] - 1][current_position[1]].color != color) || (!board_state[current_position[0] - 1].nil? && board_state[current_position[0] - 1][current_position[1]].instance_of?(String))) && ((0..7).include?(current_position[0] - 1) && !king_check?(board_state,
                                                                                                                                                                                                                                                                                                                                                                                                                       [
                                                                                                                                                                                                                                                                                                                                                                                                                         current_position[0] - 1, current_position[1]
                                                                                                                                                                                                                                                                                                                                                                                                                       ]))
      return [[current_position[0] - 1, current_position[1]]]
    end

    []
  end

  def king_check?(board_state, move)
    # so at our smallest problem we want to select the rows starting from one up unless it's nil in which case we ignore it so
    row = -1
    until row == 2
      if board_state[move[0]].nil? || (board_state[move[0] + row][move[1] - 1] != nil && board_state[move[0] + row][move[1] - 1].class.to_s == 'King')
        return false
      end
      if board_state[move[0] + row][move[1]] != nil && board_state[move[0] + row][move[1]].class.to_s == 'King'
        return false
      end
      if board_state[move[0] + row][move[1] + 1] != nil && board_state[move[0] + row][move[1] + 1].class.to_s == 'King'
        return false
      end

      row += 1
    end
    true
  end

  def clear_top_left?(board_state)
    board_state[0][1..3].each do |board_cell|
      return false if board_cell.class != String
    end
    return false if board_state[0][0].instance_of?(String)

    true
  end

  def clear_top_right?(board_state)
    board_state[0][5..6].each do |board_cell|
      return false if board_cell.class != String
    end
    return false if board_state[0][7].instance_of?(String)

    true
  end

  def clear_bottom_left?(board_state)
    board_state[7][1..3].each do |board_cell|
      return false if board_cell.class != String
    end
    return false if board_state[7][0].instance_of?(String)

    true
  end

  def clear_bottom_right?(board_state)
    board_state[7][5..6].each do |board_cell|
      return false if board_cell.class != String
    end
    return false if board_state[7][7].instance_of?(String)

    true
  end

  def found_moves_casteling(board_state)
    found_moves = []
    if clear_top_left?(board_state) && board_state[0][0].class.to_s == 'Rook' && board_state[0][0].color == color && current_position[1] == 4 && current_position[0] == 0
      left_end = 4 - 2
      until left_end == 5
        break if in_check_castleing?(board_state, [0, left_end])

        found_moves.push([0, 2]) if left_end == 4
        left_end += 1
      end
    end
    if clear_top_right?(board_state) && board_state[0][7].class.to_s == 'Rook' && board_state[0][7].color == color && current_position[1] == 4 && current_position[0] == 0
      right_end = 4 + 2
      until right_end == 3

        break if in_check_castleing?(board_state, [0, right_end])

        found_moves.push([0, 6]) if right_end == 4
        right_end -= 1

      end
    end

    if clear_bottom_left?(board_state) && board_state[7][0].class.to_s == 'Rook' && board_state[7][0].color == color && current_position[1] == 4 && current_position[0] == 7
      left_end = 4 - 2
      until left_end == 5

        break if in_check_castleing?(board_state, [0, left_end])

        found_moves.push([7, 2]) if left_end == 4
        left_end += 1
      end
    end

    if clear_bottom_right?(board_state) && board_state[7][7].class.to_s == 'Rook' && board_state[7][7].color == color && current_position[1] == 4 && current_position[0] == 7
      right_end = 4 + 2
      until right_end == 3
        break if in_check_castleing?(board_state, [7, right_end])

        found_moves.push([7, 6]) if right_end == 4
        right_end -= 1

      end
    end

    # return false if no conditions are true. also if statements ensure the king is on the proper row
    found_moves
  end

  def in_check?(board_state, coordinates = [current_position[0], current_position[1]])
    board_state.each do |board_row|
      board_row.each do |board_cell|
        next unless board_cell.respond_to?(:color) && board_cell.color != color

        found_pieces_moves = board_cell.legal_moves(board_state)
        return true if board_cell.valid_move?(board_state, coordinates)
      end
    end

    false
  end

  def in_check_castleing?(board_state, coordinates = [current_position[0], current_position[1]])
    board_state.each do |board_row|
      board_row.each do |board_cell|
        next unless board_cell.respond_to?(:color) && board_cell.class.to_s != 'King'

        found_pieces_moves = board_cell.legal_moves(board_state)
        return true if board_cell.valid_move?(board_state, coordinates)
      end
    end

    false
  end

  def matched_moves_check?(board_state, found_pieces_moves)
    self_moves = legal_moves(board_state)
    self_moves.each do |move|
      return true if found_pieces_moves.any?(move)
    end
    false
  end

  def validate_input(found_moves, input)
    found_moves.each do |item|
      return true if !item.nil? && item == input
    end
    false
  end

  def check_cause_pieces(board_state)
    found_pieces = []
    board_state.each do |row|
      row.each do |board_cell|
        next unless board_cell.respond_to?(:color) && board_cell.valid_move?(board_state,
                                                                                        [current_position[0],
                                                                                         current_position[1]]) && board_cell.color != color

        found_pieces.push(board_cell)
      end
    end
    found_pieces
  end

  def check_removal_pieces(board_state)
    found_pieces = check_cause_pieces(board_state)
    return [] if found_pieces.empty?

    available_pieces = []
    board_state.each do |row|
      row.each do |board_cell|
        next unless board_cell.respond_to?(:color) && board_cell.valid_move?(board_state,
                                                                                        [found_pieces[0].current_position[0],
                                                                                         found_pieces[0].current_position[1]]) && board_cell.color == color

        available_pieces.push(board_cell)
      end
    end
    available_pieces
  end
end
