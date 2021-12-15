module GameMessages
    def color_selection(color_one,color_two)
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
        puts "You chose an empty board cell. Select a occupied square."
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
        end
    end

end

new_color = a.each {|item| puts "\033[48;5;57m#{item}\033[0m" }