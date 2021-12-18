# frozen_string_literal: true

require_relative 'generic_moves'
require 'pry-byebug'
class Bishop
  attr_accessor :current_position, :previous_position, :color
  include GenericMoves
  def initialize
    @current_position = nil
    @previous_position = nil
    @color = nil
  end

  def generate_symbol
    if color == 'black'
      '♝'
    elsif color == 'white'
      '♗'
    end
  end

  def set_color(color)
    @color = color
  end

  def set_position(position)
    if @previous_position.nil?
      @current_position = position
    else
      @previous_position = @current_position
      @current_position = position
    end
  end

  def valid_move?(board_state, input)
    if valid_input(board_state, input)
      available_moves = legal_moves(board_state)
      valid_move(input, available_moves)
    else
      false
    end
  end

  def legal_moves(board_state)
    legal_moves = []
    legal_moves.concat(diagonal_moves_left(board_state, self))
    legal_moves.concat(diagonal_moves_right(board_state, self))

    legal_moves
  end

  def valid_input(board_state, input)
  
    if (0..board_state.length).include?(input[0]) && (0..board_state[input[0]].length).include?(input[1])
      true
    else
      false
    end
  end

  def valid_move(input, legal_moves)
    legal_moves.each do |legal_move|
      return true if input == legal_move
    end
    false
  end
end
