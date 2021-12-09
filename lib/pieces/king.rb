
require "pry-byebug"
class King

    attr_accessor :color, :current_position, :previous_position, :available_moves_values
    attr_reader :name

    def initialize
        @name = "King"
        @color = nil
        @current_position = nil 
        @previous_position = nil
        @available_move_values = nil
    end

    def set_color(color)
        @color = color
    end

    def set_position(position) 
        if(@current_position == nil)
            @current_position = position
        else
            @previous_position = @current_position
            @current_position = position 
        end
    end

    def valid_move?(board_state,input) 
        legal_moves = any_moves?(board_state)
        move_validity = validate_input(legal_moves,input)
        if(move_validity == true)
        self.set_position(input)
        end
        return move_validity
    end

    def legal_moves(board_state)
        @available_move_values = []
        #so now we want to get the current board position as a reference to our moves
        @available_move_values.push(any_moves?(board_state))
    end

    def any_moves?(board_state)
        #so a move can be one of three ways. the way we could test this is by checking the vertical sides then the middle side
        found_moves = []

        found_moves_left = left_vertical_moves(board_state)
        if (!found_moves_left.nil?)
        found_moves_left.each { |item| found_moves.push(item) }
        end
        found_moves_right = right_vertical_moves(board_state)
        if (!found_moves_right.nil?)
        found_moves_right.each { |item| found_moves.push(item) }
        end
        found_moves_top = top_move(board_state)
        if (!found_moves_top.nil?)
        found_moves_top.each { |item| found_moves.push(item)}
        end 
        found_moves_bottom = bottom_move(board_state)
        if (!found_moves_bottom.nil?)
        found_moves_bottom.each { |item| found_moves.push(item) }
        end
        found_moves_casteling = found_moves_casteling(board_state)
        if (!found_moves_casteling.nil?)
            found_moves_casteling.each { |item| found_moves.push(item)}
        end
 
        return found_moves
    end

    def left_vertical_moves(board_state)

        if((0..board_state[current_position[0]].length).include?(current_position[1] - 1))   
            valid_verticals_left = []
            #we loop through the code and if a position isn't higher the conditional above we include it
            possible_moves = [[current_position[0] - 1,current_position[1] - 1], [current_position[0], current_position[1] - 1], [current_position[0] + 1, current_position[1] - 1]]
            possible_moves.each do |position|
                if ((0..board_state[current_position[0]].length - 1).include?(position[0]))
                    valid_verticals_left.push(position)
                end
            end
            return valid_verticals_left
        end
    end

    def right_vertical_moves(board_state)
        if ((0..board_state[current_position[0]].length).include?(current_position[1] + 1))
            valid_verticals_right = []
            possible_moves = [[current_position[0],current_position[1] + 1], [current_position[0] + 1, current_position[1] + 1], [current_position[0] - 1, current_position[1] + 1]]
            possible_moves.each do |position|
                if ((0..board_state[current_position[0]].length - 1).include?(position[0]))
                    valid_verticals_right.push(position)
                end
            end
        end
        return valid_verticals_right
    end

    def top_move(board_state) 
       
            if (!board_state[current_position[0] + 1].nil? && (0..board_state[current_position[0] + 1].length).include?(current_position[1] + 1))

                return [[current_position[0] + 1,current_position[1]]]
            end
    end

    def bottom_move(board_state)
       if (!board_state[current_position[0] - 1].nil? && (0..board_state[current_position[0] - 1].length).include?(current_position[0] - 1))
            return [[current_position[0] - 1, current_position[1]]]
       end
    end

    def clear_top_left?(board_state)
        
        board_state[0][1..3].each do |board_cell|
            if(board_cell.class != String)
                return false 
            end 
            
        end
        if(board_state[0][0].class == String)
            return false 
        end
            return true
    end

    def clear_top_right?(board_state)
        board_state[0][5..6].each do |board_cell|
            if(board_cell.class != String)
                return false
            end
        end
            if(board_state[0][7].class == String)
                return false 
            end
            return true 
         end
 
    
        def clear_bottom_left?(board_state)
            board_state[7][1..3]. each do |board_cell|
                if(board_cell.class != String)
                    return false
                end
            end
                if(board_state[7][0].class == String)
                    return false 
                end
                return true 
        end

        def clear_bottom_right?(board_state)
            board_state[7][5..6]. each do |board_cell|
                if(board_cell.class != String)
                    return false
                end
            end
                if(board_state[7][7].class == String)
                    return false 
                end
                return true 
        end
   

    def found_moves_casteling(board_state)
        found_moves = []
        #check if a rook exists on either side
        
            if(clear_top_left?(board_state) && board_state[0][0].name == 'Rook' && board_state[0][0].color != "Black" && self.current_position[1] == 4 && self.current_position[0] == 0 ) 
                left_end = 4 - 2
                until left_end == 5
                    
                if(in_check?(board_state,[0,left_end]))
                break
                end
                if(left_end == 4)
                    found_moves.push([0,2])
                end
                left_end += 1
                end
            end

                if(clear_top_right?(board_state) && board_state[0][7].name == 'Rook' && board_state[0][7].color != "Black" && self.current_position[1] == 4 && self.current_position[0] == 0)
                    right_end = 4 + 2
                until right_end == 3
                   
                    if(in_check?(board_state,[0,right_end]))
                        break
                    end
                    p right_end

                    if(right_end == 4)

                        found_moves.push([0,6])
                    end
                    right_end -= 1

                end
            end

               #check if a rook exists on either side
               
               if(clear_bottom_left?(board_state) && board_state[7][0].name == 'Rook' && board_state[7][0].color != "Black" && self.current_position[1] == 4 && self.current_position[0] == 7 ) 
                left_end = 4 - 2
                until left_end == 5
                    
                if(in_check?(board_state,[0,left_end]))
                    break 
                end
                if(left_end == 4)
                   
                    found_moves.push([7,2])
                end
                left_end += 1
                end
            end

                if(clear_bottom_right?(board_state) && board_state[7][7].name == 'Rook' && board_state[7][7].color != "Black" && self.current_position[1] == 4 && self.current_position[0] == 7 )
                    right_end = 4 + 2
                until right_end == 3
                    
                    if(in_check?(board_state,[7,right_end]))
                        break
                    end
                    if(right_end == 4)
                        found_moves.push([7,6])
                    end
                    right_end -= 1

                end
            end

        #return false if no conditions are true. also if statements ensure the king is on the proper row 
        return found_moves
    end
    def in_check?(board_state,coordinates)
        board_state.each do |board_row|
            #check each board row and see if if the coordinates and if so return true else return als 
            #binding.pry
            board_row.each do |board_cell|

                        if(board_cell.class != String && board_cell.color != self.color && board_cell.valid_move?(board_state,coordinates))
                        return true 

                        end
            end
        end
        
        return false 
    end


    def validate_input(found_moves,input)

        found_moves.each do |item|

            if(!item.nil? && item == input)
            return true
            end
        end
        return false
    end
end
