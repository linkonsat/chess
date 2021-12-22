# frozen_string_literal: true

require 'pry-byebug'
class AI
  attr_accessor :color

  def select_color(board_state)
    if board_state.class == String
      @color = board_state
    else
      color_options = found_colors(board_state)
      @color = color_options[rand(1)]
    end
  end

  def found_colors(board_state)
    found_colors = []
    board_state.each do |row|
      row.each do |board_cell|
        if board_cell.methods.include?(:color) && !found_colors.include?(board_cell.color)
          found_colors.push(board_cell.color)
          end
      end
    end
    found_colors
  end

  def move_choice(board_state)
    found_pieces = gather_pieces(board_state)
    piece_moves = piece_moves(found_pieces,board_state)
    choice = generate_move_choice(found_pieces, piece_moves, board_state)
    return choice
  end

  def gather_pieces(board_state)
    found_pieces = []
    board_state.each do |row|
      row.each do |board_cell|
        if board_cell.methods.include?(:color) && board_cell.color == color
          found_pieces.push(board_cell)
          end
      end
    end
    found_pieces
  end

  def piece_moves(pieces,board_state)
    possible_moves = []
    pieces.each do |piece|
      found_legal_moves = piece.legal_moves(board_state)
      if(!found_legal_moves[0].nil?)
      possible_moves.push(piece.legal_moves(board_state))
      end
    end
    possible_moves
  end
end

def generate_move_choice(found_pieces, piece_moves, board_state)
  checked_moves = []
  total_moves = piece_moves.flatten.length
  random_piece = rand(found_pieces.length)
  random_move_set = rand(piece_moves.length - 1)
  random_move = rand(piece_moves[random_move_set].length - 1)

  until found_pieces[random_piece].valid_move?(board_state,piece_moves[random_move_set][random_move])
    unless piece_moves[random_move_set][random_move].nil?
      checked_moves.push(piece_moves[random_move_set][random_move])
     end
    random_piece = rand(found_pieces.length)
    random_move_set = rand(piece_moves.length - 1)
    random_move = rand(piece_moves[random_move_set].length - 1)
  end
  [found_pieces[random_piece], piece_moves[random_move_set][random_move]]
end
# select rand up to the number of choices right.
