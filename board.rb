class Board
    attr_accessor :board
    @board = [1,2,3,4,5,6,7,8,9]
    def initialize
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]}"
        puts "---+---+---+"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]}"
        puts "---+---+---+"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]}"
    end
    
end
