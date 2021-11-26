class Pawn
    attr_accessor :current_position, :previous_position, :color

    def initialize
        @current_position = nil 
        @previous_position = nil 
        @color = nil
    end

    def set_color(color) 
        @color = color 
    end
end