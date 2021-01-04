class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# What would happen if we added a `play` method to the `Bingo` class, keeping in mind that there is already a method of this name in the `Game` class that the `Bingo` class inherits from.

# Our new `play` method would override the `play` method inherited from the `Game` class, and this `play` method would be used instead of looking up the chain to find the `play` method in the `Game` class.

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end

  def play
    "This is a Bingo game!"
  end
end

bingo = Bingo.new
p bingo.play # => "This is a Bingo game!"