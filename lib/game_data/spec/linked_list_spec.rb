# frozen_string_literal: true

require '../linked_list'
describe GameHistory do
  describe '#tail' do
    subject(:game_history) { described_class.new }
    it 'Returns the last node in the list.' do
      game_board = double('GameBoard', board: Array.new(8) { Array.new(8, '[]') })
      game_board_new = double('GameBoard', board: Array.new(8) { Array.new(8, ':D') })
      game_history.insert(game_board.board)
      game_history.insert(game_board_new.board)
      expect(game_history.tail.data).to eql(game_board_new.board)
    end
  end
  describe '#head' do
    subject(:game_history) { described_class.new }
    it 'Returns the first node in the list.' do
      game_board = double('GameBoard', board: Array.new(8) { Array.new(8, '[]') })
      game_board_new = double('GameBoard', board: Array.new(8) { Array.new(8, ':D') })
      game_history.insert(game_board.board)
      game_history.insert(game_board_new.board)
      expect(game_history.head.data).to eql(game_board.board)
    end
  end
  describe '#insert_node' do
    subject(:game_history) { described_class.new }
    it 'Inserts new game data at when added' do
      game_board = double('GameBoard', board: Array.new(8) { Array.new(8, '[]') })
      game_board_new = double('GameBoard', board: Array.new(8) { Array.new(8, ':D') })
      game_board_last = double('GameBoard', board: Array.new(8) { Array.new(8, ':O') })
      game_history.insert(game_board.board)
      game_history.insert(game_board_new.board)
      game_history.insert(game_board_last.board)
      expect(game_history.tail.data).to eql(game_board_last.board)
      expect(game_history.head.data).to eql(game_board.board)
    end
  end
  describe '#rewind' do
    subject(:game_history) { described_class.new }
    it 'Inserts a new game data and gets rid of of old history when rewinded' do
      game_board = double('GameBoard', board: Array.new(8) { Array.new(8, '[]') })
      game_board_old = double('GameBoard', board: Array.new(8) { Array.new(8, 'old') })
      game_history.insert(game_board.board)
      game_history.insert(game_board_old.board)
      game_history.rewind
      expect(game_history.head.data).to eql(game_board.board)
    end
  end
  describe '#return_history' do
    subject(:game_history) { described_class.new }
    it 'By default returns the last history of the move before the current one' do
      game_board = double('GameBoard', board: Array.new(8) { Array.new(8, '[]') })
      game_board_old = double('GameBoard', board: Array.new(8) { Array.new(8, ':D') })
      game_history.insert(game_board.board)
      game_history.insert(game_board_old.board)
      expect(game_history.return_history[0]).to eql(game_board_old.board)
    end
    it 'Returns node up to or less than the amount of requested nodes entered' do
      game_board = double('GameBoard', board: Array.new(8) { Array.new(8, '[]') })
      15.times do
        game_history.insert(game_board.board)
      end
      retrieved_history = game_history.return_history(10)
      expect(retrieved_history.length).to eql(10)
      expect(retrieved_history.all?(game_board.board)).to eql(true)
    end

    it 'Does not throw an error when requested history goes beyond list length' do
      game_board = double('GameBoard', board: Array.new(8) { Array.new(8, '[]') })
      5.times do
        game_history.insert(game_board.board)
      end
      retrieved_history = game_history.return_history(10)
      expect(retrieved_history.length).to eql(5)
      expect(retrieved_history.all?(game_board.board)).to eql(true)
      expect(retrieved_history.count(game_board.board)).to eql(5)
    end
  end
end
