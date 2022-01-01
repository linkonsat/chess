# frozen_string_literal: true

require 'pry-byebug'
class Knight
  attr_accessor :color, :previous_position, :current_position

  def initialize
    @color = nil
    @previous_position = nil
    @current_position = nil
  end

  def set_color(color)
    @color = color
  end

  def generate_symbol
    if color == 'black'
      '♞'
    elsif color == 'white'
      '♘'
    end
  end

  def set_position(position)
    @previous_postion = @current_position
    @current_position = position
  end

  def valid_input(board_state, input)
    if (0..board_state.length - 1).include?(input[0]) && (0..board_state[0].length - 1).include?(input[1])
      true
    else
      false
    end
  end

  def legal_moves(board_state)
    legal_moves = [[1, 2], [2, -1], [2, 1], [1, -2], [-2, 1], [-2, -1], [-1, 2], [-1, -2]]
    verified_legal_moves = []
    legal_moves.each do |potential_move|
      new_row = potential_move[0] + current_position[0]
      new_collumn = potential_move[1] + current_position[1]
      if !board_state[new_row].nil? && !board_state[new_row][new_collumn].nil? && board_state[new_row][new_collumn].instance_of?(String)
        verified_legal_moves.push([new_row, new_collumn])
      end
      if !board_state[new_row].nil? && !board_state[new_row][new_collumn].nil? && board_state[new_row][new_collumn].methods.include?(:color) && board_state[new_row][new_collumn].color != color
        verified_legal_moves.push([new_row, new_collumn])
      end
    end
    verified_legal_moves
  end

  def valid_move?(board_state, input)
    if valid_input(board_state, input)
      valid_moves = legal_moves(board_state)
      verified_move(valid_moves, input)
    else
      false
    end
  end

  def verified_move(valid_moves, input)
    return true if valid_moves.any?(input)

    false
  end
end
