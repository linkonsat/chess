# frozen_string_literal: true

require_relative '../game'

# tests should cover round,conclusion,setup,

describe Game do
  describe '#setup' do
    subject(:game) { described_class.new }
    it 'Sets up the accurate game instance variables' do
      allow(game).to receive(:gets).and_return(0)
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
  describe '#round' do
    subject(:game) { described_class.new }
    it 'Runs a game round sucessfully' do
      rook = double('Rook', class: 'Rook', current_position: [0, 0], color: 'black', valid_move?: true)
      game.setup
      allow(game.winning_conditions).to receive(:fifty_moves?).and_return(false, true)
      allow(game.player_list[0]).to receive(:select_move).and_return([5, 5], [5, 5])
      allow(game.player_list[0]).to receive(:select_piece).and_return(rook, rook)
      game.round
      expect(game.board.board[5][5]).to eql(rook)
      expect(game.fifty_move_rule_counter).to eql(0)
    end
    it "Runs a ai game round successfully" do
    allow(game).to receive(:game_type).and_return("AI vs AI")
    allow(game).to receive(:gets).and_return("N")
    game.game_run
    expect(game).to receive(:conclusion).once
  end
end

  describe '#player_turn' do
    subject(:game) { described_class.new }
    it 'Selects the correct player after the previous player has had their turn.' do
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

  describe "#game_type" do 
  subject(:game) {described_class.new}
  it "Loops until AI vs AI is entered." do 
    allow(game).to receive(:gets).and_return("fun","AI vs AI")
    game_type = game.game_type
    expect(game_type).to eql("AI vs AI")
  end
  it "Loops until player vs player is entered." do 
    allow(game).to receive(:gets).and_return("fun","player vs player")
    game_type = game.game_type 
    expect(game_type).to eql("player vs player")
  end
end
end
