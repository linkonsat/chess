require_relative "../player_set"
require "pry-byebug"
describe ChessSet do 
    describe "#create_white_set" do 
    subject(:white_set) {described_class.new}
    it "Returns a standard white set of chess pieces" do 
        created_white_set = white_set.create_white_set
        expect(created_white_set[0].any?(Rook)).to eql(true)
        expect(created_white_set[0].any?(Bishop)).to eql(true)
        expect(created_white_set[0].any?(King)).to eql(true)
        expect(created_white_set[0].any?(Queen)).to eql(true)
        expect(created_white_set[0].any?(Knight)).to eql(true)
        expect(created_white_set[1].all?(Pawn)).to eql(true)
    end
end

describe "#create_black_set" do 
subject(:black_set) {described_class.new}
it "Returns a standard black set of chess pieces" do 
    created_black_set = black_set.create_black_set
    expect(created_black_set[0].any?(Rook)).to eql(true)
        expect(created_black_set[0].any?(Bishop)).to eql(true)
        expect(created_black_set[0].any?(King)).to eql(true)
        expect(created_black_set[0].any?(Queen)).to eql(true)
        expect(created_black_set[0].any?(Knight)).to eql(true)
        expect(created_black_set[1].all?(Pawn)).to eql(true)
end
end
end