require './players'

LIVES = 3
OPERATIONS = [:+, :*, :-]


def initialize_players
  @players = [
      Player.new("Player 1", 0),
      Player.new("Player 2", 1)
  ]
end

def set_players
  print "How many players do you want? (2-6)"
  totalplayers = gets.chomp.to_i
  if totalplayers < 2 || totalplayers > 6
    puts "Please enter a number of players between 2 and 6"
    set_players
  elsif totalplayers == 2
    return
  else
    (3..totalplayers).each do |id|
      @players << Player.new("Player #{id}", id)
    end
  end
end

def set_names
  @players.each do |player|
    print "#{player.name} please enter your name:"
    player.name = gets.chomp
  end
end

def generate_question
  @sign = OPERATIONS[rand(0..2)]
  @num1 = rand(1..20).to_i
  @num2 = rand(1..20).to_i
  @answer = @num1.send(@sign, @num2)
end

def prompt_for_answer(name)
  print "\n#{name}: What is #{@num1} #{@sign} #{@num2}? "
  @response = gets.chomp.to_i
end

def verify?
  @answer == @response
end

def update_scores(player)
    if verify?
      player.gain_point
      puts "\e[32m\nCorrect!\n\e[0m"
    else 
      player.lose_life
      if player.lives > 1
        puts "\e[31m\nWrong! #{player.name} you have #{player.lives} lives left!\n\e[0m"
        show_scores
      else
        puts "\e[31m\nWrong! #{player.name} you have 1 life left!\n\e[0m"
        show_scores
      end
    end
end

def show_scores
  @players.each do |player|
    puts "#{player.name} your score is #{player.score}."
  end
end

def end_if_loser(player)
  if player.lives == 1 && !verify?
    puts "\e[31m\nWrong! #{player.name}, you have lost all your lives, game over!\n\e[0m"
    end_menu
  end
end


def reset_lives
  @players.each do |player|
    player.lives = LIVES
  end
end

def end_menu
  show_scores
  print "\nNew game with same players? (Y/N) "
  input = gets.chomp.upcase
  if input == "Y"
    reset_lives
    run
  else
    abort("\nThanks for playing!\n\n")
  end
end