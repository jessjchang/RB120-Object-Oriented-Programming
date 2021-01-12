class GuessingGame
  MAX_GUESSES = 7
  RANGE = 1..100

  attr_accessor :guesses

  def initialize
    @number = rand(RANGE)
    @guesses = MAX_GUESSES
  end

  def play
    play_round
    display_final_outcome
    reset
  end

  private

  attr_reader :number
  attr_accessor :guess

  def play_round
    loop do
      display_remaining_guesses
      take_turn
      display_guess_result
      break if won? || out_of_guesses?
    end
  end

  def display_remaining_guesses
    if guesses == 1
      puts "You have #{guesses} guess remaining."
    else
      puts "You have #{guesses} guesses remaining."
    end
  end

  def valid_guess?(guess)
    (1..100).include?(guess)
  end

  def confirm_guess
    loop do
      print "Enter a number between 1 and 100: "
      self.guess = gets.chomp.to_i
      break if valid_guess?(guess)
      print "Invalid guess. "
    end
  end

  def reduce_guesses
    self.guesses -= 1
  end

  def take_turn
    confirm_guess
    reduce_guesses
  end

  def won?
    guess == number
  end

  def out_of_guesses?
    guesses == 0
  end

  def display_guess_result
    if guess > number
      puts "Your guess is too high."
    elsif guess < number
      puts "Your guess is too low."
    else
      puts "That's the number!"
    end
    puts ""
  end

  def display_final_outcome
    if won?
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end

  def reset
    @number = rand(RANGE)
    self.guesses = MAX_GUESSES
  end
end

game = GuessingGame.new
game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

# You won!

game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!

# FURTHER EXPLORATION

class GuessingGame
  MAX_GUESSES = 7
  RANGE = 1..100

  def initialize
    @number = rand(RANGE)
    @player = Player.new
  end

  def play
    play_round
    display_final_outcome
    reset
  end

  private

  attr_reader :number, :player

  def play_round
    loop do
      display_remaining_guesses
      player.take_turn
      display_guess_result
      break if player_won? || player.out_of_guesses?
    end
  end

  def display_remaining_guesses
    if player.remaining_guesses == 1
      puts "You have #{player.remaining_guesses} guess remaining."
    else
      puts "You have #{player.remaining_guesses} guesses remaining."
    end
  end

  def player_won?
    player.guess == number
  end

  def display_guess_result
    if player.guess > number
      puts "Your guess is too high."
    elsif player.guess < number
      puts "Your guess is too low."
    else
      puts "That's the number!"
    end
    puts ""
  end

  def display_final_outcome
    if player_won?
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end

  def reset
    @number = rand(RANGE)
    @player = Player.new
  end
end

class Player
  attr_accessor :guess, :remaining_guesses

  def initialize
    @remaining_guesses = GuessingGame::MAX_GUESSES
  end

  def take_turn
    confirm_guess
    reduce_remaining_guesses
  end

  def out_of_guesses?
    remaining_guesses == 0
  end

  private

  def valid_guess?(guess)
    (1..100).include?(guess)
  end

  def confirm_guess
    loop do
      print "Enter a number between 1 and 100: "
      self.guess = gets.chomp.to_i
      break if valid_guess?(guess)
      print "Invalid guess. "
    end
  end

  def reduce_remaining_guesses
    self.remaining_guesses -= 1
  end
end

game = GuessingGame.new
game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

# You won!