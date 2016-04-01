@PlayerOneScore = 0
@PlayerTwoScore = 0
@PlayerOneFails = 0
@PlayerTwoFails = 0
@CurrentPlayer = 1
require 'byebug'
require 'colorize'

def prompt
  puts "Player #{@CurrentPlayer}: What is #{@first} plus #{@second}?"
  @response = gets.chomp.to_i
end

def generate_question
  @first = rand(1..20).to_i
  @second = rand(1..20).to_i
  @answer = (@first + @second)
end

def verify
  @answer == @response
end

def scores
  if @CurrentPlayer == 1 && verify
    @PlayerOneScore += 1 
    @CurrentPlayer += 1
    puts "\e[32m"
    puts "Correct!"
    puts "\e[0m"
  elsif @CurrentPlayer == 1
    @PlayerOneFails += 1
    @CurrentPlayer += 1
    puts "\e[31m"
    puts "Wrong! Your current score is #{@PlayerOneScore} with #{@PlayerOneFails} fails"
    puts "\e[0m"
  elsif @CurrentPlayer == 2 && verify
    @PlayerTwoScore += 1
    @CurrentPlayer -= 1
    puts "\e[32m"
    puts "Correct!"
    puts "\e[0m"
  elsif @CurrentPlayer == 2
    @PlayerTwoFails += 1
    @CurrentPlayer -= 1
    puts "\e[31m"
    puts "Wrong! Your current score is #{@PlayerTwoScore} with #{@PlayerTwoFails} fails"
    puts "\e[0m"
  end
end

def checkforloser
  if @PlayerTwoFails == 3
    abort("Player two, you have lost all your lives! Your score was #{@PlayerTwoScore} and the winner "\
         "Player One has #{@PlayerOneScore}!")  
  end
  if @PlayerOneFails == 3
    abort("Player 1, you have lost all your lives! Your score was #{@PlayerOneScore} and the winner "\
         "Player 2 has a score of #{@PlayerTwoScore}!")
  end
end

loop do
  generate_question
  prompt
  verify
  # byebug
  scores
  checkforloser
end
