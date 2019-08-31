class Player
    def introduction
        puts "Player One, what's your name?"
        $p1 = gets.chomp
        self.ask_symbol
        puts "Player Two, what's your name?"
        $p2 = gets.chomp
        @p1_symbol == "O" ? $p2_symbol = "X" : $p2_symbol = "O"
        puts "#{$p2}, your symbol is #{p2_symbol}"
    end
    def ask_symbol
        puts "#{$p1}, what's your symbol, X or O?"
        gets.chomp.upcase == "O" || "X" ? $p1_symbol = gets.chomp.upcase : ask_symbol
end