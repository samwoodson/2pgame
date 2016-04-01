require 'byebug'
require 'colorize'
LIVES = 3

@players = [
  {
    id: 1,
    lives: LIVES,
    score: 0
  },
  {
    id: 2,
    lives: LIVES,
    score: 0
  }
]

def prompt(player_num)
  puts "Player #{player_num}: What is #{@num1} plus #{@num2}?"
  @response = gets.chomp.to_i
end

def generate_question
  @num1 = rand(1..20).to_i
  @num2 = rand(1..20).to_i
  @answer = (@num1 + @num2)
end

def verify
  @answer == @response
end

def scores(player_key)
    if verify
      @players[player_key - 1][:score] += 1
      puts "\e[32m"
      puts "Correct!"
      puts "\e[0m"
    else 
      @players[player_key - 1][:lives] -= 1
      puts "\e[31m"
      puts "Wrong! You have #{@players[player_key - 1][:lives]} lives left!"
      puts "\e[0m"
  end
end

def show_scores
  puts "Player #{@players[0][:id]} your score is #{@players[0][:score]}."
  puts "Player #{@players[1][:id]} your score is #{@players[1][:score]}."
end

def checkforloser(player_key)
  if @players[player_key - 1][:lives] == 0
    abort("Player #{@players[player_key - 1][:id]}, you have lost all your lives, game over! "\
          "Player #{@players[0][:id]} your score was #{@players[0][:score]}, "\
          "Player #{@players[1][:id]} your score was #{@players[1][:score]}.")
    
  end
end

loop do
  @players.each do |player|
    generate_question
    prompt(player[:id])
    verify
    # byebug
    scores(player[:id])
    checkforloser(player[:id])
    show_scores
  end
end
