require_relative "ai"
require_relative "board"
require_relative "end_conditions"
require_relative "game_messages"
require_relative "player_set"
require_relative "player"
require_relative "saved_game"
require "pry-byebug"
class Game 
    attr_accessor :fifty_move_rule_counter, :total_turns
include GameMessages
    def initialize
        @fifty_move_rule_counter = 0
        @total_turns = 0
        @board = Board.new
        @player_list = []
        @sets = ChessSet.new
    end

    def game_run
        self.setup
        self.round
        self.conclusion
    end
    def setup 
        #first we create the players
        black_set = @sets.create_black_set
        white_set = @sets.create_white_set
        @board.set_pieces_standard(white_set,black_set)
        puts @board.display_used_board
        create_players
    end

    def create_players
        2.times do 
            @player_list.push(Player.new)
        end
        self.color_selection(@board.board[0][0].color,@board.board[7][0].color)
        @player_list[0].set_color(@board[0][0].color,@board[7][0].color)
        if(player_list[0].color == "black")
            @player_list[1].color = "white"
        elsif(@player_list[0].color == "white")
            @player_list[1].color = "black"
        end
    end 
end