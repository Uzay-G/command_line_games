class Game
    require_relative "player"
    require_relative "board"
    def initialize
        @win_positions = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
                          [2, 5, 8], [3, 6, 9], [1, 5, 9], [7, 5, 3]]
        @current_player = nil
    end
    def play
        puts "Welcome to this command line Ruby game of Tic Tac Toe!".center(20)
        puts "It was made as part of the Odin Project curriculum".center(20)

        def self.introduction
            puts "Player One, what's your name?"
            @p1 = gets.chomp
            puts "Player Two, what's your name?"
            @p2 = gets.chomp
            loop do
                puts "#{@p1}, what's your symbol, X or O?"
                @p1_symbol = gets.chomp.upcase
                next unless  @p1_symbol == "O" || @p1_symbol == "X"
                @p2_symbol = @p1_symbol == "O" ? "X" : "O"
                break
            end
            puts "#{@p2}, your symbol is #{@p2_symbol}"
        end
        self.introduction

        @@plateau = Board.new
        @player1 = Player.new(@p1, @p1_symbol)
        @player2 = Player.new(@p2, @p2_symbol)
        until won? || tie?
        turn
        end
        play_again?
    end
    def turn
        @current_player = @current_player == @player1 ? @player2 : @player1
        puts "#{@current_player.name}'s turn"
        @@plateau.display
        loop do
            puts "Type the number of the box you want to play in"
            target = gets.chomp.to_i
            next unless target.between?(1,9) && occupied?(target)
            @current_player.moves << target
            @@plateau.board[@current_player.moves[-1] - 1] = @current_player.symbol
            break
        end
    end
    ## Checking methods
    def won? 
        for i in @win_positions do
            if i.sort == @player1.moves.sort || i.sort == @player2.moves.sort
                puts @@plateau.display, "\n #{@current_player.name} won!!"
                return true
            end
        end
        false
    end
    def occupied? position
        @@plateau.board[position - 1].class == Integer ? true : false
    end
    def tie?
        status = true
        @@plateau.board.each {|i| status = false if i.class == Integer}
        puts "It's a tie! No one won" if status == true
        return status
    end
    def play_again?
        puts "Do you want to play again? Enter Y to play and anything else to stop"
        answer = gets.chomp.upcase
        Game.new.play if answer == "Y"
        puts "All right! Have a good one" if answer != "Y"
    end
end
require_relative "board"
Game.new.play