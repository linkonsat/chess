# frozen_string_literal: true

require_relative './pieces/king'
require_relative './pieces/pawn'
require_relative './pieces/queen'
require_relative './pieces/rook'
require_relative './pieces/bishop'
require_relative './pieces/knight'
#require 'pry-byebug'
class ChessSet
  def initialize
    black_set = create_black_set
    white_set = create_white_set
  end

  def create_black_set
    black_set = [[Rook.new, Knight.new, Bishop.new, Queen.new, King.new, Bishop.new, Knight.new, Rook.new],
                 [Pawn.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new]]
    black_set[0].each { |piece| piece.set_color('black') }
    black_set[1].each { |piece| piece.set_color('black') }
    black_set
  end

  def create_white_set
    white_set = [[Rook.new, Knight.new, Bishop.new, Queen.new, King.new, Bishop.new, Knight.new, Rook.new],
                 [Pawn.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new, Pawn.new]]
    white_set[0].each { |piece| piece.set_color('white') }
    white_set[1].each { |piece| piece.set_color('white') }
    white_set
  end

  def new_piece
    choice = gets.chomp
    if choice == 'Rook'
      Rook.new
    elsif choice == 'Queen'
      Queen.new
    elsif choice == 'Bishop'
      Bishop.new
    elsif choice == 'Knight'
      Knight.new
    else
      new_piece
    end
  end

  def generate_piece(input)
    if(input == "p" || input == "P")
      return Pawn.new
    elsif(input == "r" || input == "R")
      return Rook.new 
    elsif(input == "K" || input == "k")
      return Knight.new 
    elsif(input == "B" || input == "b")
      return Bishop.new 
    elsif(input == "q" || input == "Q")
      return Queen.new 
    elsif(input == "k" || input == "K")
      return King.new 
    end
  end
end
