# frozen_string_literal: true

require 'pry-byebug'
class AI
  attr_accessor :color

  def select_color(board_state)
    if board_state.instance_of?(String)
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
    found_king = found_pieces.select { |piece| (piece.class.to_s == 'King' && piece.color == color) }
    binding.pry if found_king[0].nil?
    if found_king[0].in_check?(board_state, found_king[0].current_position)
      king_moves = found_king[0].legal_moves(board_state)
      found_moves = []
      king_moves.each do |move|
        return [found_king[0], move] unless found_king[0].in_check?(board_state, move)
      end
      unless found_king[0].check_removal_pieces(board_state).empty?
        possible_pieces = found_king[0].check_removal_pieces(board_state)
        checkmate_cause_pieces = found_king[0].check_cause_pieces(board_state)
        selected_piece = find_removal_move(board_state, possible_pieces, checkmate_cause_pieces)
        return selected_piece
      end
    end
    piece_moves = piece_moves(found_pieces, board_state)
    choice = generate_move_choice(found_pieces, piece_moves, board_state)
    p choice
    choice
  end

  def find_removal_move(board_state, possible_pieces, checkmate_cause_pieces)
    checkmate_cause_pieces.each do |piece|
      possible_pieces.each do |capture_piece|
        return [capture_piece, piece.current_position] if capture_piece.valid_move?(board_state, piece.current_position)
      end
    end
  end

  def gather_pieces(board_state)
    found_pieces = []
    board_state.each do |row|
      row.each do |board_cell|
        found_pieces.push(board_cell) if board_cell.methods.include?(:color) && board_cell.color == color
      end
    end
    found_pieces
  end

  def piece_moves(pieces, board_state)
    possible_moves = []
    pieces.each do |piece|
      found_legal_moves = piece.legal_moves(board_state)
      possible_moves.push(piece.legal_moves(board_state)) unless found_legal_moves[0].nil?
    end
    possible_moves
  end
end

def generate_move_choice(found_pieces, piece_moves, board_state)
  return false if piece_moves.flatten.empty?

  checked_moves = []
  total_moves = piece_moves.flatten.length
  random_piece = rand(found_pieces.length)
  random_move_set = rand(piece_moves.length - 1)
  random_move = rand(piece_moves[random_move_set].length - 1)
  i = 0
  until found_pieces[random_piece].valid_move?(board_state, piece_moves[random_move_set][random_move])
    i += 1
    binding.pry if i == 160
    checked_moves.push(piece_moves[random_move_set][random_move]) unless piece_moves[random_move_set][random_move].nil?
    random_piece = rand(found_pieces.length)
    random_move_set = rand(piece_moves.length - 1)
    random_move = rand(piece_moves[random_move_set].length - 1)
  end
  [found_pieces[random_piece], piece_moves[random_move_set][random_move]]
end
