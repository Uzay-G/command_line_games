require_relative "screen"
require 'colorize'
class Game
    def initialize
        @dict = File.readlines "5desk.txt"
        loop do
            $word = @dict[rand(@dict.length)].downcase.gsub!(/\s/, "")
            break if $word.length <= 12 && $word.length >= 5
        end
        $hidden = "_" * $word.length
        @@screen = Screen.new
        play
    end
    $tried = []
    $mistakes = 0
    def play
        @@screen.start_play
        until won? || $mistakes == 9
            loop do
                @@screen.turn
                @letter = gets.chomp.downcase
                next unless @letter.match(/^[a-z]+$/) && @letter.length == 1
                if $tried.include? @letter
                    puts "\n You already tried this letter!"
                    next
                end
                $tried << @letter
                correct?
                break 
            end
        end
        @@screen.won_or_lost?
    end
    def correct? 
        if $word.include?(@letter)
            puts "You got it right! That letter was in the word!".green
            $hidden.each_char.with_index {|v, i| $hidden[i] = @letter if $word[i] == @letter }
        else
            $mistakes += 1
            puts "Sorry, you got that one wrong".red
            @@screen.displays($mistakes)
        end
    end
    def won?
        return $hidden == $word;end
    def play_again?
        puts "Do you want to play another round? Enter Y if you do and anything else if you do not."
        Game.new if gets.chomp.upcase == "Y"
    end
end

class Screen
    def initialize
        puts "Welcome to this command line version of the hangman game!
You will try to guess a word in a limited amount of tries. You can save also save a game and play it later."
        print "

         /\\  /\\__ _ _ __ ___   __ _ _ __ ___   __ _ _ __  
        / /_/ / _` | '  _ \\ / _` | '_ ` _ \\ / _` | '_ \\ 
        / __  / (_| | | | | | (_| | | | | | | (_| | | | |
        \\/ /_/ \\__,_| |_| |_|\\__, |_| |_| |_|\\__,_|_| |_|
                            |___/                       
        ".red
        sleep(0.4)
        puts "Let's play!"
    end
    def displays(level)
        puts "\n ______________________________________________________\n\n\n".red
        puts "|".red if level == 1
        puts "|\n|".red if level == 2
        puts " /\n|\n|".red if level == 3
        puts "  /\n /\n|\n|".red if level == 4
        puts "   ______\n  /\n /\n|\n|".red if level == 5
        puts "   ______\n  /      | \n /\n|\n|".red if level == 6
        puts "   ______\n  /      | \n /      /|\\\n|\n|".red if level == 7
        puts "   ______\n  /      | \n /      /|\\\n|        |\n|".red if level == 8
        puts "   ______\n  /      | \n /      /|\\\n|       _|_\n|".red if level == 9
        puts "\n HANGMAN \n".red
    end
    def turn 
        puts "You have #{9 - $mistakes} tries left before the hangman dies. What's your guess? "
        puts "\n #{$hidden}"
        puts "\n\n You have tried the letters: \n #{$tried}"
    end
    def start_play
        puts "The #{$word.length} letter word you will need to guess has been picked. \n Good Luck!"
    end
    def won_or_lost?
        puts $hidden == $word ? "You did it! You saved the hangman".green : "Too bad. You ran out of tries. The word was #{$word}".red
    end
end
Game.new
