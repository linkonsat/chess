class Rook 
    attr_accessor :color, :current_position, :previous_position

    def initialize
        @color = nil 
        @current_position = nil 
        @previous_position = nil 
    end

    def set_color(selected_color)
        @color = selected_color 
    end

    def set_position(current_position)
        if(@current_position.nil?)
            @current_position = current_position 
        else 
            @previous_postion = current_position
            @current_position = current_position 
        end 
    end

    def valid_move?(board_state,input)
    end
end