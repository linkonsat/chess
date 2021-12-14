require_relative "./pieces/king"
require_relative "./pieces/pawn"
require_relative "./pieces/queen"
require_relative "./pieces/rook"
require_relative "./pieces/bishop"
require_relative "./pieces/knight"
require "pry-byebug"
class ChessSet
    def initialize
    black_set = create_black_set
    white_set = create_white_set
    end

    def create_black_set
        black_set = [[Rook.new(),Knight.new(),Bishop.new(),Queen.new(),King.new(),Bishop.new(),Knight.new(),Rook.new],[Pawn.new(),Pawn.new(),Pawn.new(),Pawn.new(),Pawn.new(),Pawn.new(),Pawn.new(),Pawn.new()]]
        black_set[0].each { |piece| piece.set_color("black")}
        black_set[1].each { |piece| piece.set_color("black")}
        return black_set
    end
    def create_white_set
        white_set = [[Rook.new(),Knight.new(),Bishop.new(),Queen.new(),King.new(),Bishop.new(),Knight.new(),Rook.new],[Pawn.new(),Pawn.new(),Pawn.new(),Pawn.new(),Pawn.new(),Pawn.new(),Pawn.new(),Pawn.new()]]
        white_set[0].each { |piece| piece.set_color("white")}
        white_set[1].each { |piece| piece.set_color("white")}
        return white_set
    end
end