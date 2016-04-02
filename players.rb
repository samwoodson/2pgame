class Player
  attr_accessor :name, :id, :lives, :score

  def initialize(name, id)
    @name = name
    @id = id
    @lives = LIVES
    @score = 0
  end

  def gain_point
    self.score += 1
  end

  def lose_life
    self.lives -= 1
  end

end

 