require "pry-byebug"
class AI

    attr_accessor :color 

    def select_color(board_state)
        if(board_state.class == String)
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
                if(board_cell.methods.include?(:color) && !found_colors.include?(board_cell.color))
                    found_colors.push(board_cell.color)
                end
            end
        end
        return found_colors
    end

    def piece_moves(pieces)
        possible_moves = []
        pieces.each {|piece| possible_moves.push(piece.legal_moves)}
        return possible_moves
    end
end