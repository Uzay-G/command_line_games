class Game
    require_relative "player"
    require_relative "board"
    def initialize
        @win_positions = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
                          [2, 5, 8], [3, 6, 9], [1, 5, 9], [7, 5, 3]]
    end
    def self.turn
        current_player = current_player == player2 ? player1 : player2
        puts "#{current_player.name}'s turn"
        board.display
        puts "Type the number of the box u want to play in"
    end
    def play
        puts "Welcome to this command line Ruby game of Tic Tac Toe!".center(20)
        puts "It was made as part of the Odin Project curriculum".center(20)

        def self.introduction
            puts "Player One, what's your name?"
            @p1 = gets.chomp
            puts "Player Two, what's your name?"
            @p2 = gets.chomp
            i = 0
            while i == 0
                puts "#{@p1}, what's your symbol, X or O?"
                @p1_symbol = gets.chomp.upcase
                next unless  @p1_symbol == "O" || @p1_symbol == "X"
                @p2_symbol = @p1_symbol == "O" ? "X" : "O"
                i = 1
            end
            puts "#{@p2}, your symbol is #{@p2_symbol}"
        end

        self.introduction

        @plateau = Board.new
        @player1 = Player.new(@p1, @p1_symbol)
        @player2 = Player.new(@p2, @p2_symbol)
        current_player = @player2
        puts won?
        until won? || tie?
        turn
        end
    end
    def turn
        current_player = current_player == @player2 ? @player1 : @player2
        puts "#{current_player.name}'s turn"
        @plateau.display
        puts @plateau.board
        puts "Type the number of the box u want to play in"
        current_player.moves << gets.chomp
    end
    ## Checking methods
    def won? 
        for i in @win_positions do
            if i.sort == @player1.moves.sort || i.sort == @player2.moves.sort
                #puts "#{current_player.name} won! I hope you enjoyed your game :)"
                #puts "Play again? Y/N"
                return true
            end
        end
        false
    end
    def occupied? position
        @plateau.board[position - 1].is_a? Integer ? true : false
    end
    def tie?
        @plateau.board.each {|i| i.is_a? Integer ? false : true}
    end
    
    

    
end
require_relative "board"
Game.new.play