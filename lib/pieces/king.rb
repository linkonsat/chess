# frozen_string_literal: true
#rewrite king valid move method to actually return true on the proper conditions
require 'pry-byebug'
class King
  attr_accessor :color, :current_position, :previous_position, :available_moves_values
  attr_reader :name

  def initialize
    @name = 'King'
    @color = nil
    @current_position = nil
    @previous_position = nil
    @available_move_values = nil
  end

  def set_color(color)
    @color = color
  end

  def generate_symbol
    if color == 'black'
      '♚'
    elsif color == 'white'
      '♔'
    end
  end

  def set_position(position)
    if @current_position.nil?
      @current_position = position
    else
      @previous_position = @current_position
      @current_position = position
    end
  end

  def valid_move?(board_state, input)
    legal_moves = any_moves?(board_state)
    move_validity = validate_input(legal_moves, input)
    move_validity
  end

  def legal_moves(board_state)
    @available_move_values = []
    # so now we want to get the current board position as a reference to our moves
    @available_move_values = any_moves?(board_state)
  end

  def any_moves?(board_state)
    # so a move can be one of three ways. the way we could test this is by checking the vertical sides then the middle side
    found_moves = []
    found_moves_left = left_vertical_moves(board_state)
    found_moves_left&.each { |item| found_moves.push(item) }
    found_moves_right = right_vertical_moves(board_state)
    found_moves_right&.each { |item| found_moves.push(item) }
    found_moves_top = top_move(board_state)
    found_moves_top&.each { |item| found_moves.push(item) }
    found_moves_bottom = bottom_move(board_state)
    found_moves_bottom&.each { |item| found_moves.push(item) }
    found_moves_casteling = found_moves_casteling(board_state)
    found_moves_casteling&.each { |item| found_moves.push(item) }
    found_moves
  end

  def left_vertical_moves(board_state)
    if (0..board_state[current_position[0]].length).include?(current_position[1] - 1)
      valid_verticals_left = []
      possible_moves = [[current_position[0] - 1, current_position[1] - 1], [current_position[0], current_position[1] - 1], [current_position[0] + 1, current_position[1] - 1]]
      possible_moves.each do |position|
        if (!board_state[position[0]].nil? && board_state[position[0]][position[1]].methods.include?(:color) && board_state[position[0]][position[1]].color != self.color)
          if((0..7).include?(position[0]) && (0..7).include?(position[1]))
          valid_verticals_left.push(position)
          end
        end
      end
      valid_verticals_left
    end
  end

  def right_vertical_moves(board_state)
    if (0..board_state[current_position[0]].length).include?(current_position[1] + 1)
      valid_verticals_right = []
      possible_moves = [[current_position[0], current_position[1] + 1], [current_position[0] + 1, current_position[1] + 1], [current_position[0] - 1, current_position[1] + 1]]
      possible_moves.each do |position|
        if (!board_state[position[0]].nil? && board_state[position[0]][position[1]].methods.include?(:color) && board_state[position[0]][position[1]].color != self.color)
          if((0..7).include?(position[0]) && (0..7).include?(position[1]))
          valid_verticals_right.push(position)
          end
        end
      end
    end
    #binding.pry
    valid_verticals_right
  end

  def top_move(board_state)
    if (!board_state[self.current_position[0] + 1].nil? && board_state[self.current_position[0] + 1][self.current_position[1]].methods.include?(:color)  && board_state[self.current_position[0] + 1][self.current_position[1]].color != self.color)
      if((0..7).include?(self.current_position[0] + 1))
      return [[current_position[0] + 1, current_position[1]]]
      end
    end
  end

  def bottom_move(board_state)
    if (!board_state[self.current_position[0] - 1].nil? && board_state[self.current_position[0] - 1][self.current_position[1]].methods.include?(:color)  && board_state[self.current_position[0] - 1][self.current_position[1]].color != self.color)
      if((0..7).include?(self.current_position[0] - 1))
     return [[current_position[0] - 1, current_position[1]]]
      end
    end
  end

  def clear_top_left?(board_state)
    board_state[0][1..3].each do |board_cell|
      return false if board_cell.class != String
    end
    return false if board_state[0][0].class == String

    true
  end

  def clear_top_right?(board_state)
    board_state[0][5..6].each do |board_cell|
      return false if board_cell.class != String
    end
    return false if board_state[0][7].class == String

    true
       end

  def clear_bottom_left?(board_state)
    board_state[7][1..3]. each do |board_cell|
      return false if board_cell.class != String
    end
    return false if board_state[7][0].class == String

    true
  end

  def clear_bottom_right?(board_state)
    board_state[7][5..6]. each do |board_cell|
      return false if board_cell.class != String
    end
    return false if board_state[7][7].class == String

    true
  end

  def found_moves_casteling(board_state)
    found_moves = []
    # check if a rook exists on either side

    if clear_top_left?(board_state) && board_state[0][0].class.to_s == 'Rook' && board_state[0][0].color != 'Black' && current_position[1] == 4 && current_position[0] == 0
      left_end = 4 - 2
      until left_end == 5

        break if in_check?(board_state, [0, left_end])

        found_moves.push([0, 2]) if left_end == 4
        left_end += 1
      end
      end

    if clear_top_right?(board_state) && board_state[0][7].class.to_s == 'Rook' && board_state[0][7].color != 'Black' && current_position[1] == 4 && current_position[0] == 0
      right_end = 4 + 2
      until right_end == 3

        break if in_check?(board_state, [0, right_end])
        found_moves.push([0, 6]) if right_end == 4
        right_end -= 1

      end
  end

    # check if a rook exists on either side

    if clear_bottom_left?(board_state) && board_state[7][0].class.to_s == 'Rook' && board_state[7][0].color != 'Black' && current_position[1] == 4 && current_position[0] == 7
      left_end = 4 - 2
      until left_end == 5

        break if in_check?(board_state, [0, left_end])

        found_moves.push([7, 2]) if left_end == 4
        left_end += 1
      end
   end

    if clear_bottom_right?(board_state) && board_state[7][7].class.to_s == 'Rook' && board_state[7][7].color != 'Black' && current_position[1] == 4 && current_position[0] == 7
      right_end = 4 + 2
      until right_end == 3

        break if in_check?(board_state, [7, right_end])

        found_moves.push([7, 6]) if right_end == 4
        right_end -= 1

      end
  end

    # return false if no conditions are true. also if statements ensure the king is on the proper row
    found_moves
  end

  def in_check?(board_state, coordinates)
    board_state.each do |board_row|
      # check each board row and see if if the coordinates and if so return true else return als
      # binding.pry
      board_row.each do |board_cell|
        if board_cell.class != String && board_cell.color != color && board_cell.valid_move?(board_state, coordinates)

          return true

        end
      end
    end

    false
  end

  def validate_input(found_moves, input)
    found_moves.each do |item|
      if (!item.nil? && item[0] > 0 && item == input)
        return true 
      end
    end
    false
  end
end
