require './2pgame'

def start
  initialize_players
  set_names
  run
end

def run
    @players.each do |player|
      generate_question
      prompt(player.name)
      verify
      endifloser(player)
      scores(player)
    end
  run
end

start