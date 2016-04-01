require 'byebug'
require 'colorize'
@setnameflag = false
LIVES = 3
OPERATIONS = [:+, :*, :-]

@players = [
  {
    id: 1,
    lives: LIVES,
    score: 0,
    name: ''
  },
  {
    id: 2,
    lives: LIVES,
    score: 0,
    name: ''
  }
]

def generate_question
  @sign = OPERATIONS[rand(0..2)]
  @num1 = rand(1..20).to_i
  @num2 = rand(1..20).to_i
  @answer = @num1.send(@sign, @num2)
end

def prompt(player_num)
  puts "\n#{@players[player_num - 1][:name]}: What is #{@num1} #{@sign} #{@num2}?"
  @response = gets.chomp.to_i
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
        if @players[player_key - 1][:lives] > 1
        puts "\e[31m"
        puts "Wrong! #{@players[player_key - 1][:name]} you have #{@players[player_key - 1][:lives]} lives left!"
        puts "\e[0m"
        show_scores
      else
        puts "\e[31m"
        puts "Wrong! #{@players[player_key - 1][:name]} you have 1 life left!"
        puts "\e[0m"
    end
  end
end

def show_scores
  puts "#{@players[0][:name]} your score is #{@players[0][:score]}."
  puts "#{@players[1][:name]} your score is #{@players[1][:score]}.\n"
end

def checkforloser(player_key)
  if @players[player_key - 1][:lives] == 1 && !verify
    puts "\e[31m\nWrong! #{@players[player_key - 1][:name]}, you have lost all your lives, game over!\e[0m"\
          "\e[32m\n#{@players[0][:name]} your score was #{@players[0][:score]}, "\
          "#{@players[1][:name]} your score was #{@players[1][:score]}.\n\e[0m"
    endmenu
  end
end

def set_names
  puts "Player 1 please enter your name:"
  @players[0][:name] += gets.chomp
  puts "Player 2 please enter your name:"
  @players[1][:name] += gets.chomp
  @setnameflag = true
end

def resetlives
  @players[0][:lives] = LIVES
  @players[1][:lives] = LIVES
end

def endmenu
  puts "New game? (Y/N)"
  input = gets.chomp.upcase
  if input == "Y"
    resetlives
    start
  else
    abort("\nThanks for playing!\n")
  end
end

def start
  loop do
    unless @setnameflag
      set_names
    end
    @players.each do |player|
      generate_question
      prompt(player[:id])
      verify
      # byebug
      checkforloser(player[:id])
      scores(player[:id])
    end
  end
end

start