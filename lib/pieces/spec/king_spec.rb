require_relative "../king"

describe King do 
#test should describe a valid move? Any move is valid so long as it is not off board and does NOT go into check
#King also can perform a castling move

    describe "#valid_move?" do 
    
    it "Allows valid moves in any square around it." do 

    end
    it "Does not allow valid moves outside of the board." do 
    end 
    it "Does not allow king to move itself into check" do 
    end
end

    describe "#castleing_available?" do 
    it "Allows casteling when the king or spaces are not under check." do 
    end
    it "Does not allow casteling when the king or spaces between casteling are under check" do 
    end

    describe "#in_check?" do 
    it "Returns true when the king is placed into check" do 
    end
    it "Returns true when a piece places the king into check." do 
    end
end
end
end