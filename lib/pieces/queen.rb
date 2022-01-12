# frozen_string_literal: true

require_relative 'move_rules'
require 'pry-byebug'
class Queen
  attr_accessor :current_position, :color, :previous_position

  include MoveRules
  def initialize
    @current_position = nil
    @color = nil
    @previous_position = nil
  end

  def set_position(position)
    if @current_position.nil?
      @current_position = position
    else
      @previous_position = @current_position
      @current_position = position
    end
  end

  def set_color(color)
    @color = color
  end

  def valid_move?(board_state, input)
    if valid_input?(board_state, input)
      any_moves = legal_moves(board_state)
      valid_move(any_moves, input)
    else
      false
    end
  end

  def generate_symbol
    if color == 'black'
      '♛'
    elsif color == 'white'
      '♕'
    end
  end

  def valid_input?(board_state, input)
    if !board_state[input[0]].nil? && (0..board_state[input[0]].length - 1).include?(input[0]) && (0..board_state[input[0]].length - 1).include?(input[1])
      true
    else
      false
    end
  end

  def legal_moves(board_state)
    valid_moves = []
    valid_moves.concat(vertical_moves(board_state, self))
    valid_moves.concat(horizontal_moves(board_state, self))
    valid_moves.concat(diagonal_moves_left(board_state, self))
    valid_moves.concat(diagonal_moves_right(board_state, self))
    valid_moves
  end

  def valid_move(legal_moves, input)
    legal_moves.each do |legal_move|
      return true if input == legal_move
    end
    false
  end
end
