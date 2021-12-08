class Board 
    attr_accessor :board 
    def initialize 
        @board = Array.new(8) { Array.new(8, "|___|")}
    end

    def set_pieces_standard(set_one,set_two)
        @board[0] = set_one[0]
        @board[1] = set_one[1]
        @board[6] = set_two[0]
        @board[7] = set_two[1]
    end

    def update_board(piece,new_coordinates)
        @board[new_coordinates[0]][new_coordinates[1]] = piece 
    end
end