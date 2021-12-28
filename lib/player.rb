# frozen_string_literal: true

require_relative 'game_messages'
require 'pry-byebug'
class Player
  include GameMessages
  attr_accessor :color, :choice
  def initialize
    @color = nil
  end

  def set_color(sets)
    choice = gets.chomp
    @color = sets[choice.to_i][0][0].color
  end

  def select_piece(board_state)
    select_piece_valid
    selected_position = gets.chomp
    until in_board?(selected_position, board_state) && right_piece?(selected_position, board_state)
      selected_position = gets.chomp
      if selected_position == 'save' || selected_position == 'resignation'
        return selected_position
      end
      if selected_position.length != 2
        outside_board
      elsif board_state[selected_position[0].to_i].nil?
        outside_board
      elsif board_state[selected_position[0].to_i][selected_position[1].to_i].nil?
        outside_board
      elsif board_state[selected_position[0].to_i][selected_position[1].to_i].class == String
        invalid_board_cell
      end
    end
    board_state[selected_position[0].to_i][selected_position[1].to_i]
  end

  def in_board?(input, board_state)
    if (0..board_state.length).include?(input[0].to_i) && (0..board_state[input[0].to_i].length).include?(input[1].to_i)
      true
    else
      false
    end
  end

  def right_piece?(input, board_state)
    if board_state[input[0].to_i][input[1].to_i].class != String && board_state[input[0].to_i][input[1].to_i].color == color
      true
    else
      false
    end
  end

  def select_move(board_state,piece)
    input = gets.chomp
    number_input = [input[0].to_i,input[1].to_i]
    until input.length == 2 && piece.valid_move?(board_state,number_input)
    input = gets.chomp 
    number_input = [input[0].to_i,input[1].to_i]
    end
    [input[0].to_i, input[1].to_i]
  end
end
