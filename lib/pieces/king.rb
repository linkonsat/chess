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
    validated_moves = remove_in_check_moves(board_state,legal_moves)
    move_validity = validate_input(validated_moves, input)
    move_validity
  end

  def remove_in_check_moves(board_state,legal_moves)
    board_state.each do |row|
      row.each do |board_cell|
        if(board_cell.methods.include?(:legal_moves) && board_cell.color != self.color)
          found_moves = board_cell.legal_moves(board_state)
          legal_moves.delete_if {|move| found_moves.any?(move) }
        end
      end
    end
    return legal_moves
  end
  def legal_moves(board_state)
    moves = any_moves?(board_state)
    validated_moves = remove_in_check_moves(board_state,moves)
    return validated_moves
  end

  def any_moves?(board_state)
    # so a move can be one of three ways. the way we could test this is by checking the vertical sides then the middle side
    found_moves = []
    found_moves.concat(left_vertical_moves(board_state))
    found_moves.concat(right_vertical_moves(board_state))
    found_moves.concat(top_move(board_state))
    found_moves.concat(bottom_move(board_state))
    found_moves.concat(found_moves_casteling(board_state))
    return found_moves
  end

  def left_vertical_moves(board_state)
    valid_verticals_left = []
    if (0..board_state[current_position[0]].length).include?(current_position[1] - 1)

      possible_moves = [[current_position[0] - 1, current_position[1] - 1], [current_position[0], current_position[1] - 1], [current_position[0] + 1, current_position[1] - 1]]
      
      possible_moves.each do |position|
        if ((!board_state[position[0]].nil? && board_state[position[0]][position[1]].methods.include?(:color) && board_state[position[0]][position[1]].color != self.color) || (!board_state[position[0]].nil? && board_state[position[0]][position[1]].class == String))
          if((0..7).include?(position[0]) && (0..7).include?(position[1]))
          valid_verticals_left.push(position)
          end
        end
      end
    end
    return valid_verticals_left
  end

  def right_vertical_moves(board_state)
    valid_verticals_right = []
    if (0..board_state[current_position[0]].length).include?(current_position[1] + 1)
      possible_moves = [[current_position[0], current_position[1] + 1], [current_position[0] + 1, current_position[1] + 1], [current_position[0] - 1, current_position[1] + 1]]
      possible_moves.each do |position|
        if ((!board_state[position[0]].nil? && board_state[position[0]][position[1]].methods.include?(:color) && board_state[position[0]][position[1]].color != self.color) || (!board_state[position[0]].nil? && board_state[position[0]][position[1]].class == String))
          if((0..7).include?(position[0]) && (0..7).include?(position[1]))
          valid_verticals_right.push(position)
          end
        end
      end
    end
    #binding.pry
    return valid_verticals_right
  end

  def top_move(board_state)
    if ((!board_state[self.current_position[0] + 1].nil? && board_state[self.current_position[0] + 1][self.current_position[1]].methods.include?(:color)  && board_state[self.current_position[0] + 1][self.current_position[1]].color != self.color) || (!board_state[self.current_position[0] + 1 ].nil? && board_state[self.current_position[0] + 1][self.current_position[1]].class == String))
      if((0..7).include?(self.current_position[0] + 1))
      return [[current_position[0] + 1, current_position[1]]]
      end
    end
    return []
  end

  def bottom_move(board_state)
    if ((!board_state[self.current_position[0] - 1].nil? && board_state[self.current_position[0] - 1][self.current_position[1]].methods.include?(:color)  && board_state[self.current_position[0] - 1][self.current_position[1]].color != self.color) || (!board_state[self.current_position[0] - 1 ].nil? && board_state[self.current_position[0] - 1][self.current_position[1]].class == String))
      if((0..7).include?(self.current_position[0] - 1))
     return [[current_position[0] - 1, current_position[1]]]
      end
    end
    return []
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
    if clear_top_left?(board_state) && board_state[0][0].class.to_s == "Rook" && board_state[0][0].color == self.color && current_position[1] == 4 && current_position[0] == 0
      left_end = 4 - 2
      until left_end == 5
        if (in_check?(board_state, [0, left_end]))
          break 
        end
        if (left_end == 4)
        found_moves.push([0, 2]) 
        end
        left_end += 1
      end
      end
    if clear_top_right?(board_state) && board_state[0][7].class.to_s == "Rook" && board_state[0][7].color == self.color && current_position[1] == 4 && current_position[0] == 0
      right_end = 4 + 2
      until right_end == 3

        if (in_check?(board_state, [0, right_end]))
          break 
        end
        if (right_end == 4)
        found_moves.push([0, 6]) 
        end
        right_end -= 1

      end
  end

    # check if a rook exists on either side

    if clear_bottom_left?(board_state) && board_state[7][0].class.to_s == "Rook" && board_state[7][0].color == self.color && current_position[1] == 4 && current_position[0] == 7
      left_end = 4 - 2
      until left_end == 5

        break if in_check?(board_state, [0, left_end])

        found_moves.push([7, 2]) if left_end == 4
        left_end += 1
      end
   end

    if clear_bottom_right?(board_state) && board_state[7][7].class.to_s == "Rook" && board_state[7][7].color == self.color && current_position[1] == 4 && current_position[0] == 7
      right_end = 4 + 2
      until right_end == 3
        p right_end
        break if in_check?(board_state, [7, right_end])

        found_moves.push([7, 6]) if right_end == 4
        right_end -= 1

      end
  end

    # return false if no conditions are true. also if statements ensure the king is on the proper row
    return found_moves
  end

  def in_check?(board_state, coordinates)
    board_state.each do |board_row|   
      board_row.each do |board_cell|
        if (board_cell.class != String && board_cell.color != color && board_cell.valid_move?(board_state, coordinates))

          return true

        end
      end
    end

    false
  end

  def validate_input(found_moves, input)
    found_moves.each do |item|
      if (!item.nil? && item == input)
        return true 
      end
    end
    false
  end

  def check_cause_pieces(board_state)
    found_pieces = []
    board_state.each do |row|
      row.each do |board_cell|
        if(board_cell.methods.include?(:valid_move?) && board_cell.valid_move?(board_state,[self.current_position[0],self.current_position[1]]))
          found_pieces.push(board_cell)
        end
      end
    end
    return found_pieces
  end

  def check_removal_pieces(board_state)
    found_pieces = check_cause_pieces(board_state)
    available_pieces = []
    board_state.each do |row|
      row.each do |board_cell|
        if(board_cell.methods.include?(:valid_move?) && board_cell.valid_move?(board_state,[found_pieces[0].current_position[0],found_pieces[0].current_position[1]]))
          available_pieces.push(board_cell)
        end
      end
    end
    return available_pieces
  end
          
end
