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
end