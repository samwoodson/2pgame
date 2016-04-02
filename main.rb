require './2pgame'

def start
  initialize_players
  set_players
  set_names
  run
end

def run
    @players.each do |player|
      generate_question
      prompt_for_answer(player.name)
      verify?
      end_if_loser(player)
      update_scores(player)
    end
  run
end

start