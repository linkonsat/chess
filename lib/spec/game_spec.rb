# frozen_string_literal: true

require_relative '../game'
require_relative '../pieces/pawn'
require_relative '../pieces/rook'
describe Game do
  describe '#round' do
    subject(:game) { described_class.new }
    xit 'Runs a ai game round successfully' do
      allow(game).to receive(:game_type).and_return('AI vs AI')
      allow(game).to receive(:gets).and_return('N')
      game.game_run
      expect(game).to receive(:conclusion).once
    end
    xit 'Runs a game round sucessfully' do
      rook = double('Rook', class: 'Rook', current_position: [0, 0], color: 'black', valid_move?: true)
      game.setup
      game.board.board[5][5] = rook
      allow(game.winning_conditions).to receive(:fifty_moves?).and_return(false, true)
      allow(game.player_list[0]).to receive(:select_move).and_return([5, 5], [5, 5])
      allow(game.player_list[0]).to receive(:select_piece).and_return(rook, rook)
      game.round
      expect(game.board.board[5][5]).to eql(rook)
      expect(game.fifty_move_rule_counter).to eql(0)
    end
  end
  describe '#setup' do
    subject(:game) { described_class.new }
    it 'Sets up the accurate game instance variables' do
      allow(game).to receive(:gets).and_return("0")
      game.setup
      expect(game.player_list.length).to eql(2)
      expect(game.player_list[0].color).to eql('white')
      expect(game.board.board[0].all?(String)).to eql(false)
      expect(game.board.board[1].all?(String)).to eql(false)
      expect(game.board.board[6].all?(String)).to eql(false)
      expect(game.board.board[7].all?(String)).to eql(false)
      expect(game.fifty_move_rule_counter).to eql(0)
      expect(game.total_turns).to eql(0)
    end

    it 'Properly gives ai their correct colors if ai vs ai is chosen' do
      game.setup('AI vs AI')
      expect(game.player_list[0].color).to eql('white')
    end
  end

  describe '#player_turn' do
    subject(:game) { described_class.new }
    it 'Selects the correct player after the previous player has had their turn.' do
      pawn = Pawn.new
      pawn.current_position = [0, 0]
      game.board.board[0][0] = pawn
      game.setup
      expect(game.turn).to eql(0)
    end
  end
  describe '#conclusion' do
    subject(:game) { described_class.new }
    it 'Starts a new game when Y is entered on the conclusion screen' do
      allow(game).to receive(:gets).and_return('N')
      expect(game).not_to receive(:game_run)
      game.conclusion
    end
    it 'Starts a new game when Y is entered on the conclusion screen' do
      allow(game).to receive(:gets).and_return('Y', 'N')
      allow(game.winning_conditions).to receive(:fifty_moves?).and_return(true, true)
      expect(game).to receive(:game_run).once
      game.conclusion
    end
  end

  describe '#promotion?' do
    subject(:game) { described_class.new }
    it 'Prompts player to select a new piece when a pawn reaches the end of the board.' do
      game.setup
      pawn = Pawn.new
      move = [0, 0]
      new_piece = game.promotion?(pawn, move)
      expect(new_piece).to eql(true)
    end
  end

  describe '#game_type' do
    subject(:game) { described_class.new }
    it 'Loops until AI vs AI is entered.' do
      allow(game).to receive(:gets).and_return('fun', 'AI vs AI')
      game_type = game.game_type
      expect(game_type).to eql('AI vs AI')
    end
    it 'Loops until player vs player is entered.' do
      allow(game).to receive(:gets).and_return('fun', 'player vs player')
      game_type = game.game_type
      expect(game_type).to eql('player vs player')
    end
  end

  describe '#to_msgpack' do
    subject(:game) { described_class.new }
    it 'Sends a message to msgpack when a save is requested' do
      game.setup
      expect(MessagePack).to receive(:dump).once
      game.to_msgpack
    end
  end
  describe '#unpack_save' do
    subject(:game) { described_class.new }
    it 'Turns the saved game into a hash' do
      game.setup
      saved_game = game.to_msgpack
      unpacked_game = game.unpack_save(saved_game)
      expect(unpacked_game.class).to eql(Hash)
    end
  end
  describe '#setup_saved_game' do
  subject(:game) {described_class.new}
    it 'Sets up the same game instance' do
      game.setup
      second_game = Game.new
      saved_game = game.to_msgpack
      loaded_game = second_game.load_saved_game(saved_game)
      expect(second_game.board.board[0][5].current_position).to eql(game.board.board[0][5].current_position)
    end
  end

  describe "#create_saved_players" do 
  subject(:game) {described_class.new}
  it "Creates an AI or a player when given the class string" do 
    player_list = ["Player","AI"]
    colors = ["black","white"]
    created_players = game.create_saved_players(player_list,colors)
    expect(created_players[0].class).to eql(Player)
    expect(created_players[1].class).to eql(AI)
  end
end

  describe "#fifty_move_increase" do 
  subject(:game) {described_class.new}
  it "Increase fifty move count by one when a pawn is moved" do 
    game.setup
    pawn = Pawn.new 
    coordinates = [5,5]
    game.fifty_move_increase(pawn,coordinates)
    expect(game.fifty_move_rule_counter).to eql(1)
  end
  it "Increase fifty move count by one when a piece is captured" do 
    game.setup
    rook = Rook.new  
    coordinates = [1,0]
    game.fifty_move_increase(rook,coordinates)
    expect(game.fifty_move_rule_counter).to eql(1)
  end
  it "Does not Increase fifty move count by one when piece is captured or pawn is moved" do 
  game.setup
  rook = Rook.new  
  coordinates = [5,0]
  game.fifty_move_increase(rook,coordinates)
  expect(game.fifty_move_rule_counter).to eql(0)
  end
end
end
