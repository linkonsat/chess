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
        board.each do |row|
            current_row = []
            row.each_with_index do |board_cell,index|
                if(index.even?)
                    current_row.push("\033[48;5;57m#{board_cell}\033[0m")
                else 
                    current_row.push(board_cell)
                end
            end
            new_board.push(current_row)
        end
    end

    def generate_used_board(board)
        new_board = []
        board.each do |row|
            current_row = []
            row.each_with_index do |board_cell,index|
                if(board_cell.methods.include?(:piece_symbol))
                    current_row.push("\033[48;5;57m#{board_cell.piece_symbol}\033[0m")
                else 
                    current_row.push(board_cell)
                end
            end
            new_board.push(current_row)
        end
    end
end