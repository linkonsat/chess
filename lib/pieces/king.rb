# frozen_string_literal: true
require_relative "move_rules"
# rewrite king valid move method to actually return true on the proper conditions
#require 'pry-byebug'
class King
  attr_accessor :color, :current_position, :previous_position, :available_moves_values
  attr_reader :name
  include MoveRules
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
    found_moves = self.any_moves(board_state)
    validated_moves = self.remove_in_check_moves(board_state, found_moves)
    validate_input(validated_moves, input)
  end

  def remove_in_check_moves(board_state, legal_moves)
    board_state.each do |row|
      row.each do |board_cell|
        if board_cell.methods.include?(:legal_moves) && board_cell.color != color
          found_moves = board_cell.legal_moves(board_state)
          legal_moves.delete_if { |move| found_moves.any?(move) }
        end
      end
    end
    legal_moves
  end

  def any_moves(board_state)
    moves = legal_moves(board_state)
    self.remove_in_check_moves(board_state, moves)
  end

  def legal_moves(board_state)
    found_moves = []

    found_moves.concat(self.left_vertical_moves(board_state))
    found_moves.concat(self.right_vertical_moves(board_state))
    found_moves.concat(self.top_move(board_state))
    found_moves.concat(self.bottom_move(board_state))
    found_moves.concat(self.found_moves_casteling(board_state))

    found_moves
  end


end
