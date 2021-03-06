require_relative "player_set"
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
    if piece.class.to_s == 'Pawn' && (new_coordinates[1] == piece.current_position[1] + 1 || new_coordinates[1] == piece.current_position[1] - 1)
      passant_update = passant_update(piece, new_coordinates)
      @board[passant_update[0]][passant_update[1]] = '|_|'
      @board[new_coordinates[0]][new_coordinates[1]] = piece
      @board[piece.current_position[0]][piece.current_position[1]] = '|_|'
      piece.set_position(new_coordinates)
    elsif piece.class.to_s == 'King' && (new_coordinates[1] == piece.current_position[1] + 2 || new_coordinates[1] == piece.current_position[1] - 2)
      new_castle_coordinates = castle_coordinates(piece, new_coordinates)
      if new_coordinates[1] < piece.current_position[1]
        @board[new_coordinates[0]][new_castle_coordinates] = @board[new_coordinates[0]][0]
        @board[new_coordinates[0]][0] = '|_|'
      elsif new_coordinates[1] > piece.current_position[1]
        @board[new_coordinates[0]][new_castle_coordinates] = @board[new_coordinates[0]][7]
        @board[new_coordinates[0]][7] = '|_|'
      end
      @board[new_coordinates[0]][new_coordinates[1]] = piece
      @board[piece.current_position[0]][piece.current_position[1]] = '|_|'
      piece.set_position(new_coordinates)
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
    return new_board
  end

  def display_used_board
    new_board = generate_used_board(@board)
    puts "\n#{new_board[0][0]}#{new_board[0][1]}#{new_board[0][2]}#{new_board[0][3]}#{new_board[0][4]}#{new_board[0][5]}#{new_board[0][6]}#{new_board[0][7]}
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

  def promotion_replacement(new_piece, coordinates)
    @board[coordinates[0]][coordinates[1]] = new_piece
  end

def notation 
  fen_board = ""
  @board.each_with_index do |row,index|
    row.each do |board_cell|
        if(board_cell.class == String)
          fen_board << "#"
          fen_board << "/"
        elsif(board_cell.class == Pawn && board_cell.color == "white")
          fen_board << "p"
        fen_board << "|"
        fen_board << board_cell.previous_position.to_s
        fen_board << "|"
        fen_board << board_cell.current_position.to_s
        fen_board << "|"
        fen_board << board_cell.available_move_values.to_s 
        fen_board << "|"
        fen_board << board_cell.default_moves.to_s 
        fen_board << "/"
        elsif(board_cell.class == Rook && board_cell.color == "white")
          fen_board << "r"
        fen_board << "|"
        fen_board << board_cell.previous_position.to_s
        fen_board << "|"
        fen_board << board_cell.current_position.to_s
        fen_board << "/"
        elsif(board_cell.class == Knight && board_cell.color == "white")
          fen_board << "k"
        fen_board << "|"
        fen_board << board_cell.previous_position.to_s
        fen_board << "|"
        fen_board << board_cell.current_position.to_s
        fen_board << "/"
        elsif(board_cell.class == Bishop && board_cell.color == "white")
          fen_board << "b"
        fen_board << "|"
        fen_board << board_cell.previous_position.to_s
        fen_board << "|"
        fen_board << board_cell.current_position.to_s
        fen_board << "/"
        elsif(board_cell.class == Queen && board_cell.color == "white")
          fen_board << "q"
        fen_board << "|"
        fen_board << board_cell.previous_position.to_s
        fen_board << "|"
        fen_board << board_cell.current_position.to_s
        fen_board << "/"
        elsif(board_cell.class == King && board_cell.color == "white")
          fen_board << "k"
        fen_board << "|"
        fen_board << board_cell.previous_position.to_s
        fen_board << "|"
        fen_board << board_cell.current_position.to_s
        fen_board << "/"
        elsif(board_cell.class == Pawn && board_cell.color == "black")
          fen_board << "P"
        fen_board << "|"
        fen_board << board_cell.previous_position.to_s
        fen_board << "|"
        fen_board << board_cell.current_position.to_s
        fen_board << "|"
        fen_board << board_cell.available_move_values.to_s 
        fen_board << "|"
        fen_board << board_cell.default_moves.to_s 
        fen_board << "/"
        elsif(board_cell.class == Rook && board_cell.color == "black")
          fen_board << "R"
        fen_board << "|"
        fen_board << board_cell.previous_position.to_s
        fen_board << "|"
        fen_board << board_cell.current_position.to_s
        fen_board << "/"
        elsif(board_cell.class == Knight && board_cell.color == "black")
          fen_board << "K"
        fen_board << "|"
        fen_board << board_cell.previous_position.to_s
        fen_board << "|"
        fen_board << board_cell.current_position.to_s
        fen_board << "/"
        elsif(board_cell.class == Bishop && board_cell.color == "black")
          fen_board << "B"
        fen_board << "|"
        fen_board << board_cell.previous_position.to_s
        fen_board << "|"
        fen_board << board_cell.current_position.to_s
        fen_board << "/"
        elsif(board_cell.class == Queen && board_cell.color == "black")
        fen_board << "Q"
        fen_board << "|"
        fen_board << board_cell.previous_position.to_s
        fen_board << "|"
        fen_board << board_cell.current_position.to_s
        fen_board << "/"
        elsif(board_cell.class == King && board_cell.color == "black")
          fen_board << "K"
        fen_board << "|"
        fen_board << board_cell.previous_position.to_s
        fen_board << "|"
        fen_board << board_cell.current_position.to_s
        fen_board << "/"
        end
    end
  end
  return fen_board
end
  def saved_board_setup(data)
    checked_data = 0
    organized_data = data.split("/")
    set = ChessSet.new
    new_board = []
    self.board.each_with_index do |row, row_index|
      board_row = []
      row.each_with_index do |board_cell, index|

        if(organized_data[checked_data] == "#")
          board_cell = "|_|"
          checked_data += 1
          board_row.push(board_cell)
        elsif(organized_data[checked_data] == "p" || organized_data[checked_data] == "P")
          piece_data = create_data(organized_data[checked_data])
          board_cell = set.generate_piece(piece_data[:piece])
          board_cell.color = piece_data[:color]
          board_cell.current_position = piece_data[:current_position]
          board_cell.previous_position = piece_data[:previous_position]
          board_cell.available_move_values = piece_data[:available_move_values]
          board_cell.default_moves =  piece_data[:default_moves]
          checked_data += 1
          board_row.push(board_cell)
        else
          piece_data = create_data(organized_data[checked_data])
          board_cell = set.generate_piece(piece_data[:piece])
          board_cell.color = piece_data[:color]
          board_cell.current_position = piece_data[:current_position]
          board_cell.previous_position = piece_data[:previous_position]
          checked_data += 1
          board_row.push(board_cell)
        end
      end
      new_board.push(board_row)
    end
    @board = setup_saved_board(new_board)
  end

    def setup_saved_board(new_board)
      created_board = generate_colored_board(Array.new(8) { Array.new(8, '|_|') })
      new_board.each_with_index do |row, index|
        created_board[index] = row 
      end
      return created_board
    end


    def create_data(data)
      data_hash = {}
      split_data = data.split("|")

      split_data.each_with_index do |item, index|
        if(index == 0)
          data_hash[:piece] = item 
        end
        if(index == 0 && ("a".."z").include?(item))
          data_hash[:color] = "white"
        elsif(index == 0 && ("A".."Z").include?(item))
          data_hash[:color] = "black"
        end
        if(item[0] == "[" && item[1] != "[")
          found_array = create_arrays(item)
          if(!data_hash.has_key?(:current_position))
            data_hash[:current_position] = found_array[0] 
          elsif(!data_hash.has_key?(:previous_position))
            data_hash[:previous_position] = found_array[0]
          end
        end
          if(item[0] == "[" && item[1] == "[")
            found_array = create_arrays(item)
          if(!data_hash.has_key?(:available_move_values))
            data_hash[:available_moves_values] = found_array
          elsif(!data_hash.has_key?(:default_moves))
            data_hash[:default_moves] = found_array
          end
        end
        end
      return data_hash
    end

    def create_arrays(array_items)
      split = array_items.split("")
    index = 0 
    array = []
    split.each_with_index do |item,index|
      created_array = [item.to_i,split[index+3].to_i]
      if(!array.include?(created_array) && ("0".."9").include?(item) && ("0".."9").include?(split[index+3]))
      array.push(created_array)
      end
    end
    return array
    end
end

