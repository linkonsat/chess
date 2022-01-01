# frozen_string_literal: true

require 'pry-byebug'
class EndConditions
  def checkmate?(board_state)
    found_kings = []
    board_state.each do |row|
      row.each do |board_cell|
        found_kings.push(board_cell) if board_cell.instance_of?(King)
      end
    end
    in_check = check_legal_moves?(found_kings, board_state)
  end

  def check_legal_moves?(found_kings, board_state)
    in_check_moves = []
    i = 0
    found_kings.each do |piece|
      available_moves = piece.legal_moves(board_state)
      available_moves.push(piece.current_position)
      available_moves.each do |move|
        if piece.in_check?(board_state, move)
          in_check_moves.push(true)
        else
          in_check_moves.push(false)
        end
      end
      if !piece.check_cause_pieces(board_state).empty? && in_check_moves.all?(true) && piece.check_removal_pieces(board_state).empty?
        return true
      end

      true if in_check_moves.all?(true) && !in_check_moves.empty?
    end
    false
  end

  def resignation?(player_input)
    player_input == 'resign'
  end

  def stalemate?(board_state)
    result = check_board_pieces(board_state)

    stalemate_check?(result)
  end

  def check_board_pieces(board_state)
    first_set = []
    second_set = []
    board_state.each do |row|
      row.each do |board_cell|
        if board_cell.class != String && (first_set[0].nil? || board_cell.color == first_set[0].color)
          first_set.push(board_cell)
        end
        next unless board_cell.class != String

        second_set.push(board_cell) if second_set[0].nil? || board_cell.color == second_set[0].color
      end
    end
    [first_set, second_set]
  end

  def stalemate_check?(found_pieces)
    found_pieces[0] = found_pieces[0].map { |piece| piece.class.to_s }
    found_pieces[1] = found_pieces[1].map { |piece| piece.class.to_s }
    if found_pieces[0].length == 1 && found_pieces[1].length == 1
      return true if found_pieces[0][0] == 'King' && found_pieces[1][0] == 'King'
    elsif found_pieces[0].length == 2 && found_pieces[1].length == 2
      combos = [%w[King Knight], %w[King Bishop], %w[Knight King], %w[Bishop King]]
      return true if combos.any?(found_pieces[0]) && combos.any?(found_pieces[1])
    end
    false
  end

  def fifty_moves?(no_capture_moves)
    no_capture_moves == 50
  end

  def repetition?(move_history)
    move_history_data = move_history.return_history
    board_states = []
    move_history_data.each { |item| board_states.unshift(item) }

    board_states.each do |board_state|
      return true if board_states.count(board_state) >= 5
    end
    false
  end
end
