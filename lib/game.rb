# frozen_string_literal: true

require_relative 'ai'
require_relative 'board'
require_relative 'end_conditions'
require_relative 'game_messages'
require_relative 'player_set'
require_relative 'player'
require_relative 'saved_game'
require_relative './game_data/linked_list'
require 'pry-byebug'
require 'msgpack'
class Game
  attr_accessor :fifty_move_rule_counter, :total_turns, :board, :game_history
  attr_reader :player_list, :winning_conditions

  include GameMessages
  def initialize
    @fifty_move_rule_counter = 0
    @total_turns = 0
    @board = Board.new
    @player_list = []
    @sets = ChessSet.new
    @game_history = GameHistory.new
    @winning_conditions = EndConditions.new
  end

  def game_run
    setup(game_type)
    round
    conclusion
  end

  def promotion?; end

  def setup(game_type = 'player vs player')
    black_set = @sets.create_black_set
    white_set = @sets.create_white_set
    @board.set_pieces_standard(white_set, black_set)
    puts @board.display_used_board
    if game_type == 'player vs player'
      chess_sets = [white_set, black_set]
      create_players(chess_sets)
    elsif game_type == 'AI vs AI'
      create_ai(@board.board)
    end
    @game_history.insert(@board.board)
  end

  def create_ai(board_state)
    first_ai = AI.new
    first_ai.select_color(board_state)
    second_ai = AI.new
    @player_list.push(first_ai)
    @player_list.push(second_ai)
    if @player_list[0].color == 'black'
      @player_list[1].color = 'white'
    elsif @player_list[0].color == 'white'
      @player_list[1].color = 'black'
    end
  end

  def create_players(chess_sets)
    2.times do
      @player_list.push(Player.new)
    end
    color_selection(chess_sets[0][0][0].color, chess_sets[1][0][0].color)
    @player_list[0].set_color(chess_sets)
    if @player_list[0].color == 'black'
      @player_list[1].color = 'white'
    elsif @player_list[0].color == 'white'
      @player_list[1].color = 'black'
    end
  end

  def round
    if @player_list.all?(AI)
      ai_round
    else
      player_input = 'No resignation yet'
      @game_history.insert([@board, @total_turns, @fifty_move_rule_counter])
      until @winning_conditions.checkmate?(@board.board) || @winning_conditions.resignation?(player_input) || @winning_conditions.stalemate?(@board.board) || @winning_conditions.repetition?(@game_history) || @winning_conditions.fifty_moves?(@fifty_move_rule_counter) || player_input == 'save'
        @board.display_used_board
        @game_history.insert([@board, @total_turns, @fifty_move_rule_counter])
        current_turn = turn
        selected_piece = @player_list[current_turn].select_piece(@board.board)
        p selected_piece
        if selected_piece == 'save'
          saved_data = to_msgpack
          save_game(saved_data)
          break
        end
        chosen_coordinates = @player_list[current_turn].select_move(@board.board, selected_piece)
        @board.update_board(selected_piece, chosen_coordinates)
        @total_turns += 1
      end
    end
  end

  def ai_round
    until winning_conditions.checkmate?(@board.board) || winning_conditions.stalemate?(@board.board) || winning_conditions.repetition?(@game_history) || winning_conditions.fifty_moves?(@fifty_move_rule_counter)
      @board.display_used_board
      current_turn = turn
      move_decision = @player_list[current_turn].move_choice(@board.board)
      @board.update_board(move_decision[0], move_decision[1])
      @total_turns += 1
      puts @total_turns
      binding.pry if @total_turns == 500
    end
    binding.pry
  end

  def turn
    if total_turns.even?
      0
    else
      1
    end
  end

  def promotion?(piece, chosen_coordinates)
    if piece.instance_of?(Pawn) && (chosen_coordinates[0] == 0 || chosen_coordinates[0] == 7)
      return true
    else
      return false
    end

    @sets.new_piece
  end

  def conclusion
    new_game?
    choice = gets.chomp
    game_run if choice == 'Y'
  end

  def game_type
    choice = nil
    p 'Go ahead and enter a game type'
    choice = gets.chomp until ['player vs player', 'AI vs AI'].include?(choice)
    choice
  end

  def to_msgpack
    MessagePack.dump({
                       fifty_move_rule_counter: @fifty_move_rule_counter,
                       total_turns: @total_turns,
                       board: @board,
                       player_list: @player_list,
                       sets: @sets,
                       game_history: @game_history,
                       winning_conditions: @winning_conditions
                     })
  end

  def unpack_save(save)
    MessagePack.load save
  end

  def load_saved_game(save_data)
    loaded_save = unpack_save(save_data)
    self.fifty_move_rule_counter = loaded_save['fifty_move_rule_counter']
    self.total_turns = loaded_save['total_turns']
    self.board = loaded_save['board']
    self.player_list = loaded_save['player_list']
    self.sets = loaded['sets']
    self.game_history = loaded_save['game_history']
    self.winning_conditions = loaded_save['winning_conditions']
  end

  def save_game(data)
    if Dir.exist?('game_data')
      save = File.open('game_data/chess_data.rb', 'w+')
      save.puts data
    else
      Dir.mkdir('game_data')
      save = File.open('game_data/chess_data.rb', 'w+')
      save.puts data
    end
  end
end

game = Game.new
game.game_run
