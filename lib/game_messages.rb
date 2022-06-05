# frozen_string_literal: true

module GameMessages
  def color_selection(color_one, color_two)
    puts "Enter 0 to select #{color_one} or 1 to select #{color_two}."
  end

  def select_piece_valid
    puts "Choose a square by entering the horizontal and vertical value.
For example entering 05 selects the 5th square starting from the first square 0.
Remember for this chess format the index starts from 0 the vertical value goes 0-7 "
  end

  def outside_board
    puts "You entered a position not within the board.
Select a position within 0-7."
  end

  def invalid_board_cell
    puts 'You chose an empty board cell. Select a occupied square.'
  end

  def new_game?
    puts 'Enter Y to play a new game else enter any other value to quit. Thanks for playing!'
  end

  def selected_piece(piece)
    puts "You chose #{piece.generate_symbol} at #{piece.current_position}"
  end   
end
