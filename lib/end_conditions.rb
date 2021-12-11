require "pry-byebug"
class EndConditions
    def checkmate?(board_state)
        found_kings = []
        board_state.each do |row|
            row.each do |board_cell|
                if(board_cell.class == King)
                    found_kings.push(board_cell)
                end
            end
        end
        in_check = check_legal_moves?(found_kings,board_state)
    end

    def check_legal_moves?(found_kings,board_state)
    in_check_moves = []
    i = 0
        found_kings.each do |piece|
            available_moves = piece.legal_moves(board_state)
            available_moves.push(piece.current_position)
            available_moves.each do |move| 
            if(piece.in_check?(board_state,move) || available_moves.nil?)
            in_check_moves.push(true)
            else
            in_check_moves.push(false)
            end
        end
        end
        if(in_check_moves.all?(true))
        return true
        else 
            return false
        end
    end

    def resignation?(player_input)
        if(player_input == "resign")
            return true 
        else
            return false 
        end
    end

    def stalemate?(board_state)
        #go through the test and need to gather the appropriate pieces
        result = check_board_pieces(board_state)
        #binding.pry
        return stalemate_check?(result)
      
    end

    def check_board_pieces(board_state)
        first_set = []
        second_set = []

        board_state.each do |row|
            row.each do |board_cell|
                #if its nil just push it to the first set

                if(board_cell.class != String)
                    if(first_set[0].nil? || board_cell.color == first_set[0].color)
                    first_set.push(board_cell)
                    end
                end
                if(board_cell.class != String)
                    if(second_set[0].nil? || board_cell.color == second_set[0].color)
                    second_set.push(board_cell)
                    end
                end
            end
        end
        return [first_set,second_set]
    end

    def stalemate_check?(found_pieces)
        found_pieces[0] = found_pieces[0].map {|piece| piece.class.to_s}
        found_pieces[1] = found_pieces[1].map { |piece| piece.class.to_s}
        if(found_pieces[0].length == 1 && found_pieces[1].length == 1)
        if(found_pieces[0][0] == "King" && found_pieces[1][0] == "King")
            return true
        end
        elsif(found_pieces[0].length == 2 && found_pieces[1].length == 2)
            combos = [["King","Knight"],["King","Bishop"],["Knight","King"],["Bishop","King"]]
            if(combos.any?(found_pieces[0]) && combos.any?(found_pieces[1]))
                return true 
            end
        end
        return false
    end

    def fifty_moves?(no_capture_moves)
        if(no_capture_moves == 50)
            return true 
        else
            return false 
        end
    end

    def repetition?(move_history)
        move_history.each do |board_state|
            if(move_history.count(board_state) >= 3)
                return true 
            end
        end
        return false
    end
end