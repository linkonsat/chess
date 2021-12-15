require "pry-byebug"
class Board 
    attr_accessor :board 
    def initialize 
        @board = generate_colored_board(Array.new(8) { Array.new(8, "|___|")})
    end

    def set_pieces_standard(set_one,set_two)
        @board[0] = set_one[0]
        @board[1] = set_one[1]
        @board[6] = set_two[1]
        @board[7] = set_two[0]
    end

    def update_board(piece,new_coordinates)
        @board[new_coordinates[0]][new_coordinates[1]] = piece 
    end

    def generate_colored_board(board)
        new_board = []
        board.each_with_index do |row,row_index|
            current_row = []
            row.each_with_index do |board_cell,index|
                if(index.even? && row_index.even?)
                    current_row.push("\033[48;5;57m#{board_cell}\033[0m")
                elsif(index.odd? && row_index.odd?)
                    current_row.push("\033[48;5;57m#{board_cell}\033[0m")
                else 
                    current_row.push(board_cell)
                end
            end
            new_board.push(current_row)
        end
        return new_board
    end

    def generate_used_board(board)
        new_board = []
        board.each do |row|
            current_row = []
            row.each_with_index do |board_cell,index|
                #binding.pry
                if(board_cell.methods.include?(:piece_symbol))                   
                    current_row.push("\033[48;5;57m#{board_cell.generate_symbol}\033[0m")
                else 
                    current_row.push(board_cell)
                end
            end
            new_board.push(current_row)
        end
        return new_board
    end
    def display_used_board
        new_board = generate_used_board(@board)
    puts "#{new_board[0][0]}#{new_board[0][1]}#{new_board[0][2]}#{new_board[0][3]}#{new_board[0][4]}#{new_board[0][5]}#{new_board[0][6]}#{new_board[0][7]}\n
#{new_board[1][0]}#{new_board[1][1]}#{new_board[1][2]}#{new_board[1][3]}#{new_board[1][4]}#{new_board[1][5]}#{new_board[1][6]}#{new_board[1][7]}\n
#{new_board[2][0]}#{new_board[2][1]}#{new_board[2][2]}#{new_board[2][3]}#{new_board[2][4]}#{new_board[2][5]}#{new_board[2][6]}#{new_board[2][7]}\n
#{new_board[3][0]}#{new_board[3][1]}#{new_board[3][2]}#{new_board[3][3]}#{new_board[3][4]}#{new_board[3][5]}#{new_board[3][6]}#{new_board[3][7]}\n
#{new_board[4][0]}#{new_board[4][1]}#{new_board[4][2]}#{new_board[4][3]}#{new_board[4][4]}#{new_board[4][5]}#{new_board[4][6]}#{new_board[4][7]}\n
#{new_board[5][0]}#{new_board[5][1]}#{new_board[5][2]}#{new_board[5][3]}#{new_board[5][4]}#{new_board[5][5]}#{new_board[5][6]}#{new_board[5][7]}\n
#{new_board[6][0]}#{new_board[6][1]}#{new_board[6][2]}#{new_board[6][3]}#{new_board[6][4]}#{new_board[6][5]}#{new_board[6][6]}#{new_board[6][7]}\n
#{new_board[7][0]}#{new_board[7][1]}#{new_board[7][2]}#{new_board[7][3]}#{new_board[7][4]}#{new_board[7][5]}#{new_board[7][6]}#{new_board[7][7]}\n"
    end

end

