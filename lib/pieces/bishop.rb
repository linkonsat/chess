
class Bishop
    attr_accessor :current_position, :previous_position, :color
    def initialize
        @current_position = nil 
        @previous_position = nil 
        @color = nil 
    end

    def set_color(color)
        @color = color 
    end

    def set_position(position)
        if(@previous_position.nil?)
            @current_position = position 
        else 
            @previous_position = @current_position 
            @current_position = position 
        end
    end
end