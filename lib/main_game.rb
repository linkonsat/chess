require_relative "game"
require "pry-byebug"
class MainGame 
    attr_accessor :game
    def initialize 
        @game = Game.new
    end

    def main_menu 
        choice = gets.chomp 
        if(choice == "load" && saved_game?)
            @game.load_saved_game
        elsif(choice == "new")
            @game.game_run
        elsif(choice == "Exit")
        else
            self.main_menu 
        end
    end

    def saved_game?
        if(File.exist?("./game_data/saved_game.rb"))
            return true 
        else
            return false 
        end
    end
end

class Board
    attr_accessor :grid
    attr_reader :rows, :columns
  
    def initialize(rows: 6, columns: 7)
      @rows = rows
      @columns = columns
      @grid = create_grid(rows, columns)
      # @space_array = Array.new(grid.flatten.count, Space.new)
    end
  
    def create_grid(rows, columns)
      Array.new(rows, Array.new(columns, ' '))
    end
  
    def display_board
      grid.each { |row| p row }
    end
  
    def update_board(input, symbol)
      i = -1
      i += 1 until grid[i][input - 1] == ' '
      if(grid[i])
      grid[i][input - 1] = symbol
      end
    end
  end
  
  board = Board.new
  board.update_board(6, 'X')
  board.display_board
  
  