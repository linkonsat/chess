# frozen_string_literal: true

require_relative './move_rules'
class Rook
  attr_accessor :color, :current_position, :previous_position

  include MoveRules
  def initialize
    @color = nil
    @current_position = nil
    @previous_position = nil
  end

  def set_color(selected_color)
    @color = selected_color
  end

  def set_position(current_position)
    if @current_position.nil?
      @current_position = current_position
    else
      @previous_postion = current_position
      @current_position = current_position
    end
  end

  def valid_move?(board_state, input)
    if verify_input?(board_state, input) && self.check_cause_nonking?(board_state,self,input)
      found_moves = legal_moves(board_state)
      matches_input?(found_moves, input)
    else
      puts 'Value entered is not within range of the board row'
      false
    end
  end

  def legal_moves(board_state)
    found_moves = []
    found_moves.concat(vertical_moves(board_state, self))
    found_moves.concat(horizontal_moves(board_state, self))
    found_moves
  end

  def generate_symbol
    if color == 'black'
      '♜'
    elsif color == 'white'
      '♖'
    end
  end

  def matches_input?(legal_moves, input)
    legal_moves.each do |board_cell|
      return true if board_cell == input
    end
    false
  end

  def verify_input?(board_state, input)
    if (0..board_state[0].length - 1).include?(input[0]) && (0..board_state[0].length - 1).include?(input[1])
      true
    else
      false
    end
  end
end
