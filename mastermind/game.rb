require 'colorize'
require_relative 'computer'

class Game
    def initialize
        @computer = Computer.new
        @guesses_left = 5
    end
    def play_codecreator
        @player = "computer"
        @guess = Computer.new.code
        puts "You decided to create a code which the computer will test its solving skills against! The digits of the computer's guess"
        puts "that are well positioned will be colored #{"green".green}, the digits that are in your cipher but not well positioned will be      colored #{"red".red} and the digits that are not in the code will be white."
        loop do
            puts "What's your code? Remember it has to be 4 digits long and each digit must be between 1 and 6."
            @computer.code = gets.chomp
            break if guesses_correct?(@computer.code)
        end
       
        until won? || @guesses_left <= 0
            @message = "The computer has #{@guesses_left} guesses left. Its new try is: "
            round_creator
            sleep(1)
        end
        puts "#{analysis(@guess)}
        The computer found your secret code!" if won?
        puts "The computer didn't manage to uncover your secret code" if @guesses_left <= 0
        play_again?
    end
    def play_codebreaker
        @player = "human"
        puts "The computer will analyze your guess and return the digits white if they are not in the code, #{"red".red} if the digits are in  the code but not at the right place and #{"green".green} if the digits are in the code and well-positioned."
       puts "\n The computer has decided its secret code. Let's start!"
        until won? || @guesses_left <= 0
            @message = "You have #{@guesses_left} guesses left. Enter a new one: "
            round_solver
        end
        puts "Good job! You solved the code!" if won?
        puts "Too bad! You lost by running out of guesses. The code was #{@computer.code}" if @guesses_left < 0
        play_again?
    end
    def play_again?
        puts "Do you want to play again? Enter Y if you do and anything else to stop"
        response = gets.chomp.upcase
        intro if response == "Y"
    end
    def round_creator
        puts @message
        @guesses_left -= 1
        analysis(@guess)
        generate_guess
    end
    def generate_guess
        @guess = Computer.new.code
        @correct.each {|i| @guess[i] = @computer.code[i]} if @correct.any?
    end
    def round_solver
        @guesses_left -= 1
        loop do
            puts @message
            @input = gets.chomp
            next unless guesses_correct?(@input)
            break
        end
        @guess = @input
        analysis(@guess)
    end
    def won?
        check_with = @computer.code
        return @guess == @computer.code ? true : false
    end
    def analysis(number)
        @correct = []
        analyzed = number.split("")
        analyzed.each_with_index.map do |item, index|
            if analyzed[index] == @computer.code[index]
                @correct.push(index)
                print item.to_s.green 
            elsif (@computer.code.include? item.to_s) && (@correct.all? {|i| @computer.code[i] != item.to_s})
                print item.to_s.red
            else 
                print item.to_s
            end
        end
        puts ""
    end 
    def intro
        puts "The goal of the game is to guess the four digit code of your opponent. You can either create the code and the computer will guess it or you can try to guess the computer's code.\n"
        sleep(1.3)
        loop do
            puts "Do you want to: 1. Break a code  2. Create a code\nEnter the corresponding number"
            answer = gets.chomp
            next unless answer == "1" || answer == "2"
            Game.new.play_codebreaker if answer == "1"
            Game.new.play_codecreator if answer == "2"
            break
        end
    end
    def guesses_correct?(value)
        value = value.split("")
        value.length == 4 && value.all? { |guess| guess.to_i >= 1 && guess.to_i <= 6 }
      end    
end
puts ""
puts "Welcome to this command line version of the Mastermind boardgame made in Ruby"
puts ""
puts "
_______        _                 _      ___ 
|     |___ ___| |_ ___ ___ _____|_|___ _| |
| | | | .'|_ -|  _| -_|  _|     | |   | . |
|_|_|_|__,|___|_| |___|_| |_|_|_|_|_|_|___|

".blue
Game.new.intro