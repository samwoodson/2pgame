require './players'

LIVES = 3
OPERATIONS = [:+, :*, :-]

def initialize_players
  @players = [
      Player.new("Player 1", 0),
      Player.new("Player 2", 1)
  ]
end

def set_names
  puts "Player 1 please enter your name:"
  @players[0].name = gets.chomp
  puts "Player 2 please enter your name:"
  @players[1].name = gets.chomp
end

def generate_question
  @sign = OPERATIONS[rand(0..2)]
  @num1 = rand(1..20).to_i
  @num2 = rand(1..20).to_i
  @answer = @num1.send(@sign, @num2)
end

def prompt(name)
  puts "\n#{name}: What is #{@num1} #{@sign} #{@num2}?"
  @response = gets.chomp.to_i
end

def verify
  @answer == @response
end

def scores(player)
    if verify
      player.gain_point
      puts "\e[32m"
      puts "Correct!"
      puts "\e[0m"
    else 
        player.lose_life
        if player.lives > 1
        puts "\e[31m"
        puts "Wrong! #{player.name} you have #{player.lives} lives left!"
        puts "\e[0m"
        show_scores
      else
        puts "\e[31m"
        puts "Wrong! #{player.name} you have 1 life left!"
        puts "\e[0m"
    end
  end
end

def show_scores
  puts "#{@players[0].name} your score is #{@players[0].score}."
  puts "#{@players[1].name} your score is #{@players[1].score}.\n"
end

def endifloser(player)
  if player.lives == 1 && !verify
    puts "\e[31m\nWrong! #{player.name}, you have lost all your lives, game over!\e[0m"\
          "\e[32m\n#{@players[0].name} your score was #{@players[0].score}, "\
          "#{@players[1].name} your score was #{@players[1].score}.\n\e[0m"
    endmenu
  end
end

def resetlives
  @players[0].lives = LIVES
  @players[1].lives = LIVES
end

def endmenu
  puts "New game? (Y/N)"
  input = gets.chomp.upcase
  if input == "Y"
    resetlives
    run
  else
    abort("\nThanks for playing!\n\n")
  end
end