require_relative './lib/game'
require 'pry-byebug'
class MainGame
  attr_accessor :game

  def initialize
    @game = Game.new
  end

  def main_menu
    puts "Enter new for a new game, load to load a previous game or Exit to exit the main menu"
    choice = gets.chomp
    if choice == 'load' && saved_game?
      @game.load_saved_game
    elsif choice == 'new'
      @game.game_run
    elsif choice == 'Exit'
    else
      main_menu
    end
  end

  def saved_game?
    if File.exist?('./lib/game_data/saved_game.rb')
      true
    else
      false
    end
  end
end
game = MainGame.new 
game.main_menu