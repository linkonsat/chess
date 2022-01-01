# frozen_string_literal: true

require_relative '../player_set'
require_relative '../pieces/rook'
require 'pry-byebug'
describe ChessSet do
  describe '#create_white_set' do
    subject(:white_set) { described_class.new }
    it 'Returns a standard white set of chess pieces' do
      created_white_set = white_set.create_white_set
      expect(created_white_set[0].any?(Rook)).to eql(true)
      expect(created_white_set[0].any?(Bishop)).to eql(true)
      expect(created_white_set[0].any?(King)).to eql(true)
      expect(created_white_set[0].any?(Queen)).to eql(true)
      expect(created_white_set[0].any?(Knight)).to eql(true)
      expect(created_white_set[1].all?(Pawn)).to eql(true)
    end
  end

  describe '#create_black_set' do
    subject(:black_set) { described_class.new }
    it 'Returns a standard black set of chess pieces' do
      created_black_set = black_set.create_black_set
      expect(created_black_set[0].any?(Rook)).to eql(true)
      expect(created_black_set[0].any?(Bishop)).to eql(true)
      expect(created_black_set[0].any?(King)).to eql(true)
      expect(created_black_set[0].any?(Queen)).to eql(true)
      expect(created_black_set[0].any?(Knight)).to eql(true)
      expect(created_black_set[1].all?(Pawn)).to eql(true)
    end
  end

  describe "#new_piece" do 
  subject(:chess_set) {described_class.new}
  it "Does not return the correct piece until proper input occurs" do 
    allow(chess_set).to receive(:gets).and_return("blah", "Rook")
    new_piece = chess_set.new_piece
    allow(new_piece).to eql(Rook)
  end
end
end
