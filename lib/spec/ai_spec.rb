# frozen_string_literal: true

# AI gathers all of its pieces, should then select a pice
# After ai selects a piece will keep in put random numbers until a valid move is selected and then returns said value
# AI also selects a random color or can be assigned a color if non is given through set color
require_relative '../ai'
require_relative '../pieces/knight'
require_relative '../pieces/rook'
require_relative '../pieces/king'
describe AI do
  describe '#move_choice' do
    subject(:ai) { described_class.new }
    it 'Returns false if no moves are available.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      pawn = double('Pawn', color: 'black', legal_moves: [], valid_move?: false)
      board.board[0][0] = pawn
      board.board[5][5] = King.new
      board.board[5][5].color = "black"
      board.board[5][5].set_position([5,5])
      ai.color = 'black'
      expect(ai.move_choice(board.board)).to eq(false)
    end

    it 'Finds the matching pieces on the board and returns the valid move and moves to another piece if there are no legal moves.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      pawn = double('Pawn', color: 'black', legal_moves: [], valid_move?: false)
      pawn_second = double('PawnSecond', color: 'black', legal_moves: [[1, 1]], valid_move?: true)
      board.board[0][0] = pawn
      board.board[0][1] = pawn_second
      ai.color = 'black'
      board.board[5][5] = King.new
      board.board[5][5].color = "black"
      board.board[5][5].set_position([5,5])
      expect(ai.move_choice(board.board)).to eql([pawn_second, [1, 1]])
    end
    
    it 'Calls valid method on the selected piece until true is returned and returns that value' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      pawn = double('Pawn', color: 'black', legal_moves: [[1, 1]], valid_move?: true)
      board.board[0][0] = pawn
      ai.color = 'black'
      board.board[5][5] = King.new
      board.board[5][5].color = "black"
      board.board[5][5].set_position([5,5])
      expect(ai.move_choice(board.board)).to eql([pawn, [1, 1]])
    end

    it 'Returns the piece and a set of valid coordinates when forced to capture a piece to cancel checkmate.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      ai.color = "black"
      knight = Knight.new
      knight.color = 'black'
      knight.set_position([6,5])
      king = King.new
      king.color = 'black'
      king.set_position([0,7])
      enemy_piece = Rook.new
      enemy_piece.color = 'white'
      enemy_piece.set_position([7,7])
      enemy_piece_two = Rook.new 
      enemy_piece_two.color = 'white'
      enemy_piece_two.set_position([7,6])
      board.board[0][7] = king
      board.board[7][7] = enemy_piece
      board.board[7][6] = enemy_piece_two
      board.board[6][5] = knight
      expect(ai.move_choice(board.board)).to eql([knight,[7,7]])
    end

  end

  describe '#piece_moves' do
    subject(:ai) { described_class.new }
    it 'Selects a pieces legal moves on the board.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      pawn = double('PawnSecond', color: 'black', legal_moves: [1, 1])
      expect(ai.piece_moves([pawn],board.board)).to eql([[1, 1]])
    end
    it 'Selects multiple pieces legal moves on the board.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      pawn = double('PawnSecond', color: 'black', legal_moves: [1, 1])
      expect(ai.piece_moves([pawn, pawn],board.board)).to eql([[1, 1], [1, 1]])
    end
  end
  # move choice calls all the pieces it owns on the board. after calling it. it goes one at a time and if a piece has legal moves and returns a valid move

  describe '#select_color' do
    subject(:ai) { described_class.new }
    it 'Selects a random color from the predefined sets available on the board.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      pawn = double('Pawn', color: 'black')
      second_pawn = double('PawnNew', color: 'white')
      board.board[0][0] = pawn
      board.board[7][0] = second_pawn
      found_colors = ai.select_color(board.board)
      expect(%w[white black]).to include(found_colors)
    end
    it 'Assigns a color if a color is passed through a parameter' do
      ai.select_color('white')
      expect(ai.color).to eql('white')
    end
  end
end
