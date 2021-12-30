# frozen_string_literal: true

require_relative '../player'

describe Player do
  # really all we need to test is that given a set of colored pieces the correct color is chose and when a piece is selected that the proper item has been chosen
  describe '#set_color' do
    subject(:player) { described_class.new }
    it 'Loops until a valid string selection is entered.' do
      piece = double('Pawn', :color => 'Black')
      piece_two = double('Rook', :color => 'White')
      sets = [[[piece]], [[piece_two]]]
      allow(player).to receive(:gets).and_return('[]', "white","1")
      player.set_color(sets)
      expect(player.color).to eql('White')
    end
    it 'Sets the correct color given a predefined set of pieces' do
      piece = double('Pawn', :color => 'Black')
      piece_two = double('Rook', :color => 'White')
      sets = [[[piece]], [[piece_two]]]
      allow(player).to receive(:gets).and_return("1")
      player.set_color(sets)
      expect(player.color).to eql('White')
    end
   
  end
  describe '#select_piece' do
    subject(:player) { described_class.new }
    it 'Returns the piece if selected input is valid.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      player.color = 'black'
      pawn = double('Pawn', color: 'black')
      board.board[0][0] = pawn
      allow(player).to receive(:gets).and_return('00')
      selected_piece = player.select_piece(board.board)
      expect(selected_piece).to eql(pawn)
    end
    it 'Returns the chess piece only if selected input is within the board.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      pawn = double('Pawn', color: 'black')
      player.color = 'black'
      board.board[0][0] = pawn
      allow(player).to receive(:gets).and_return('990', '99', '00')
      found_piece = player.select_piece(board.board)
      expect(found_piece).to eql(pawn)
    end
    it 'Returns the chess piece until proper input is entered after a invalid board cell is selected.' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      pawn = double('Pawn', color: 'black')
      player.color = 'black'
      board.board[0][0] = pawn
      allow(player).to receive(:gets).and_return('05', '00')
      found_piece = player.select_piece(board.board)
      expect(found_piece).to eql(pawn)
    end
    it 'Does not allow you to select a piece that is not your color' do
      board = double('Board', board: Array.new(8) { Array.new(8, '[]') })
      pawn = double('Pawn', color: 'black')
      pawn_ally = double('PawnAlly', color: 'white')
      board.board[0][1] = pawn_ally
      board.board[0][0] = pawn
      player.color = 'black'
      allow(player).to receive(:gets).and_return('01', '00')
      found_piece = player.select_piece(board.board)
      expect(found_piece).to eql(pawn)
    end
  end
end
