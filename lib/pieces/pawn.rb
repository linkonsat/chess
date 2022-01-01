# frozen_string_literal: true

require 'pry-byebug'
class Pawn
  attr_accessor :current_position, :previous_position, :color, :available_move_values, :default_moves

  def initialize(current_position = nil)
    @current_position = current_position
    @previous_position = nil
    @color = nil
    @available_move_values = []
    @default_moves = nil
  end

  def generate_symbol
    if color == 'black'
      '♟'
    elsif color == 'white'
      '♙'
    end
  end

  def set_color(color)
    @color = color
  end

  def valid_move?(board_state, input)
    validated_moves = legal_moves(board_state)
    if default_moves[0][0] > 0 && forward_step(validated_moves, input)
      true
    elsif default_moves[0][0] < 0 && backward_step(validated_moves, input)
      true

    else
      false
    end
  end

  def legal_moves(board_state)
    @available_move_values = []
    initial_moves(board_state) if @previous_position.nil?
    two_step_available(board_state)
    if @default_moves[0][0] < 0
      is_blocked_backward(board_state)
      is_attackable_backward(board_state)
      passant_forward(board_state)
    elsif @default_moves[0][0] > 0
      is_blocked_forward(board_state)
      is_attackable_forward(board_state)
      passant_backward(board_state)
    end
    @available_move_values
  end

  def set_position(new_coordinates)
    @previous_position = @current_position
    @current_position = new_coordinates
  end

  def initial_moves(board_state)
    if board_state[1].include?(self)
      @default_moves = [[1, 0], [2, 0]]
    elsif board_state[6].include?(self)
      @default_moves = [[-1, 0], [-2, 0]]
    end
    @available_move_values.push(default_moves[0], default_moves[1])
  end

  private

  def passant_forward(board_state)
    attackable_pieces = []
    if (0..board_state[current_position[0]].length).include?(current_position[1] + 1) && board_state[current_position[0]][current_position[1] + 1].class != String
      attackable_pieces.push(board_state[current_position[0]][current_position[1] + 1])
    end
    # issue is that logic path isnt pushing the piece
    # p board_state[self.current_position[0]][self.current_position[1] - 1]
    if (0..board_state[current_position[0]].length).include?(current_position[1] - 1) && board_state[current_position[0]][current_position[1] - 1].class != String
      attackable_pieces.push(board_state[current_position[0]][current_position[1] - 1])
    end
    verify_passant_forward?(attackable_pieces)
  end

  def passant_backward(board_state)
    attackable_pieces = []
    if (0..board_state[current_position[0]].length).include?(current_position[1] + 1) && board_state[current_position[0]][current_position[1] + 1].class != String
      attackable_pieces.push(board_state[current_position[0]][current_position[1] + 1])
    end
    if (0..board_state[current_position[0]].length).include?(current_position[1] - 1) && board_state[current_position[0]][current_position[1] - 1].class != String
      attackable_pieces.push(board_state[current_position[0]][current_position[1] - 1])
    end
    verify_passant_backward?(attackable_pieces)
  end

  def verify_passant_forward?(found_pieces)
    found_pieces.each do |item|
      if item.nil? || item.previous_position.nil?
      elsif item != [] && item.current_position[0] - 2 == item.previous_position[0] && item.color != color
        @available_move_values.push([item.previous_position[0] + 1, item.previous_position[1]])
      end
    end
  end

  def verify_passant_backward?(found_pieces)
    found_pieces.each do |item|
      if item.nil? || item.previous_position.nil?
      elsif item != [] && !item.previous_position.nil? && item.current_position[0] + 2 == item.previous_position[0] && item.color != color
        @available_move_values.push([item.previous_position[0] - 1, item.previous_position[1]])
      end
    end
  end

  def two_step_available(_board_state)
    if default_moves.include?([-2, 0])
      unless @previous_position.nil?
        @default_moves = [[-1, 0]]
        @available_move_values.push(@default_moves[0])
      end
    elsif default_moves.include?([2, 0])
      unless @previous_position.nil?
        @default_moves = [[1, 0]]
        @available_move_values.push(@default_moves[0])
      end
    else
      @available_move_values.push(@default_moves[0])
    end
  end

  def forward_step(validated_moves, input)
    validated_moves.each do |item|
      vertical_move_value = current_position[0] - item[0]
      horizontal_move_left = current_position[1] - item[1]
      horizontal_move_right = current_position[1] + item[1]

      return true if item == input
    end
    false
  end

  def backward_step(validated_moves, input)
    validated_moves.each do |item|
      vertical_move_value = current_position[0] + item[0]
      horizontal_move_left = current_position[1] + item[1]
      horizontal_move_right = current_position[1] + item[1]
      return true if input == item
    end
    false
  end

  def is_blocked_forward(board_state)
    i = 0
    new_row_coordinate = current_position[0] + default_moves[i][0]
    until default_moves[i].nil? || board_state[new_row_coordinate][current_position[1]].class != String || i == @default_moves.length
      new_row_coordinate = current_position[0] + default_moves[i][0]
      @available_move_values.push([new_row_coordinate, current_position[1]])
      i += 1
    end
  end

  def is_blocked_backward(board_state)
    i = 0
    new_row_coordinate = current_position[0] + default_moves[i][0]

    until default_moves[i].nil? || board_state[new_row_coordinate][current_position[1]].class != String || i == @default_moves.length
      new_row_coordinate = current_position[0] + default_moves[i][0]
      @available_move_values.push([new_row_coordinate, current_position[1]])

      i += 1
    end
  end

  def is_attackable_forward(board_state)
    attackable_positions = []
    left_move = @current_position[1] + 1
    forward_move = @current_position[0] + 1
    right_move = @current_position[1] - 1
    if !board_state[forward_move][left_move].nil? && board_state[forward_move][left_move].class != String && board_state[forward_move][left_move].color != color
      attackable_positions.push([forward_move, left_move])
    end

    if !board_state[forward_move][right_move].nil? && board_state[forward_move][right_move].class != String && board_state[forward_move][right_move].color != color
      attackable_positions.push([forward_move, right_move])
    end
    remove_duplicates(attackable_positions)
  end

  def is_attackable_backward(board_state)
    attackable_positions = []
    left_move = @current_position[1] + 1
    forward_move = @current_position[0] - 1
    right_move = @current_position[1] - 1
    if board_state[forward_move][left_move].nil?

    elsif board_state[forward_move][left_move].class != String && board_state[forward_move][left_move].color != color
      attackable_positions.push([forward_move, left_move])
    end
    if board_state[forward_move][right_move].nil?
    elsif board_state[forward_move][right_move].class != String && board_state[forward_move][right_move] != color
      attackable_positions.push([forward_move, right_move])
    end
    remove_duplicates(attackable_positions)
  end

  def remove_duplicates(found_moves)
    found_moves.each do |item|
      @available_move_values.push(item) if !@available_move_values.include?(item) && !item.nil?
    end
  end
end
