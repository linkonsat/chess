# frozen_string_literal: true

require 'pry-byebug'
class Board
  attr_accessor :board
  def initialize
    @board = generate_colored_board(Array.new(8) { Array.new(8, '|_|') })
  end

  def set_pieces_standard(set_one, set_two)
    @board[0] = assign_position(0, set_one[0])
    @board[1] = assign_position(1, set_one[1])
    @board[6] = assign_position(6, set_two[1])
    @board[7] = assign_position(7, set_two[0])
  end

  def assign_position(row, set)
    new_set = []
    set.each_with_index do |item, index|
      item.set_position([row, index])
      new_set.push(item)
    end
    new_set
  end

  def update_board(piece, new_coordinates)
    if (piece.class.to_s == 'Pawn' && (new_coordinates[1] == piece.current_position[1] + 1 || new_coordinates[1] == piece.current_position[1] - 1))
      passant_update = passant_update(piece, new_coordinates)
      @board[passant_update[0]][passant_update[1]] = '|_|'
      @board[new_coordinates[0]][new_coordinates[1]] = piece
    elsif (piece.class.to_s == 'King' && (new_coordinates[1] == piece.current_position[1] + 2 || new_coordinates[1] == piece.current_position[1] - 2))
      new_castle_coordinates = castle_coordinates(piece, new_coordinates)
      if new_coordinates[1] < piece.current_position[1]
        @board[new_coordinates[0]][new_castle_coordinates] = @board[new_coordinates[0]][0]
        @board[new_coordinates[0]][0] = '|_|'
      elsif new_coordinates[1] > piece.current_position[1]
        @board[new_coordinates[0]][new_castle_coordinates] = @board[new_coordinates[0]][7]
        @board[new_coordinates[0]][7] = '|_|'
      end
      @board[new_coordinates[0]][new_coordinates[1]] = piece
    else
      @board[new_coordinates[0]][new_coordinates[1]] = piece
      @board[piece.current_position[0]][piece.current_position[1]] = '|_|'
      piece.set_position(new_coordinates)
    end
  end

  def castle_coordinates(piece, new_coordinates)
    if new_coordinates[1] < piece.current_position[1]
      new_coordinates[1] + 1
    elsif new_coordinates[1] > piece.current_position[1]
      new_coordinates[1] - 1
    end
  end

  def generate_colored_board(board)
    new_board = []
    board.each_with_index do |row, row_index|
      current_row = []
      row.each_with_index do |board_cell, index|
        if index.even? && row_index.even?
          current_row.push("\033[48;5;57m#{board_cell}\033[0m")
        elsif index.odd? && row_index.odd?
          current_row.push("\033[48;5;57m#{board_cell}\033[0m")
        else
          current_row.push(board_cell)
        end
      end
      new_board.push(current_row)
    end
    new_board
  end

  def generate_used_board(board)
    new_board = []
    board.each_with_index do |row, row_index|
      current_row = []
      row.each_with_index do |board_cell, index|
        if board_cell.methods.include?(:generate_symbol) && index.even? && row_index.even?
          current_row.push("\033[48;5;57m|#{board_cell.generate_symbol}|\033[0m")
        elsif board_cell.methods.include?(:generate_symbol) && index.odd? && row_index.odd?
          current_row.push("\033[48;5;57m|#{board_cell.generate_symbol}|\033[0m")
        elsif board_cell.methods.include?(:generate_symbol)
          current_row.push("|#{board_cell.generate_symbol}|")
        elsif index.even? && row_index.even?
          current_row.push("\033[48;5;57m#{board_cell}\033[0m")
        elsif index.odd? && row_index.odd?
          current_row.push("\033[48;5;57m#{board_cell}\033[0m")
        else
          current_row.push('|_|')
        end
      end
      new_board.push(current_row)
    end
    new_board
  end

  def display_used_board
    new_board = generate_used_board(@board)
    puts "#{new_board[0][0]}#{new_board[0][1]}#{new_board[0][2]}#{new_board[0][3]}#{new_board[0][4]}#{new_board[0][5]}#{new_board[0][6]}#{new_board[0][7]}
#{new_board[1][0]}#{new_board[1][1]}#{new_board[1][2]}#{new_board[1][3]}#{new_board[1][4]}#{new_board[1][5]}#{new_board[1][6]}#{new_board[1][7]}
#{new_board[2][0]}#{new_board[2][1]}#{new_board[2][2]}#{new_board[2][3]}#{new_board[2][4]}#{new_board[2][5]}#{new_board[2][6]}#{new_board[2][7]}
#{new_board[3][0]}#{new_board[3][1]}#{new_board[3][2]}#{new_board[3][3]}#{new_board[3][4]}#{new_board[3][5]}#{new_board[3][6]}#{new_board[3][7]}
#{new_board[4][0]}#{new_board[4][1]}#{new_board[4][2]}#{new_board[4][3]}#{new_board[4][4]}#{new_board[4][5]}#{new_board[4][6]}#{new_board[4][7]}
#{new_board[5][0]}#{new_board[5][1]}#{new_board[5][2]}#{new_board[5][3]}#{new_board[5][4]}#{new_board[5][5]}#{new_board[5][6]}#{new_board[5][7]}
#{new_board[6][0]}#{new_board[6][1]}#{new_board[6][2]}#{new_board[6][3]}#{new_board[6][4]}#{new_board[6][5]}#{new_board[6][6]}#{new_board[6][7]}
#{new_board[7][0]}#{new_board[7][1]}#{new_board[7][2]}#{new_board[7][3]}#{new_board[7][4]}#{new_board[7][5]}#{new_board[7][6]}#{new_board[7][7]}"
  end

  def passant_update(piece, new_input)
    if new_input[0] < piece.current_position[0]
      [new_input[0] + 1, new_input[1]]
    else
      [new_input[0] - 1, new_input[1]]
    end
  end
end
