class Knight 
    attr_accessor :color, :previous_position, :current_position 
    def initialize 
        @color = nil
        @previous_position = nil 
        @current_position = nil 
    end

    def select_color(color)
        @color = color 
    end

    def set_position(position)
        @previous_postion = @current_position
        @current_position = position 
    end
end