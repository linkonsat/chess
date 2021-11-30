require_relative "../rook"


describe Rook do 

    #tests should describe it going horizontally and haiving it stopping at the piece
    #test should describe it not being able to move past piece
    #test should return true upon a castling move
    describe "#valid_move?" do 
    subject(:rook) {described_class.new}
    it "Returns true on a valid move direction without a block" do 
        board = double("Board", => Array.new(8) {Array.new(8, "[]")})
    end

    it "Returns false on a invalid move direction" do 
    end
end

    describe "#horizontal_move" do 
    it  "Returns only moves along horizontal paths" do 
    end

    it "Returns only moves up to a piece in the horizontal path" do 
    end
end

    describe "#vertical_move" do 
    it "Returns only moves along vertical paths" do 
    end

    it "Returns only moves along vertical move up to a piece in the path"
end


end
end