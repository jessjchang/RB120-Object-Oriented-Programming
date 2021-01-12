class GuessingGame
  attr_accessor :guesses

  def initialize(low, high)
    @lowest_value = low
    @highest_value = high
    reset
  end

  def play
    play_round
    display_final_outcome
    reset
  end

  private

  attr_reader :number, :lowest_value, :highest_value
  attr_accessor :guess

  def size_of_range
    (highest_value - lowest_value) + 1
  end

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
    (lowest_value..highest_value).include?(guess)
  end

  def confirm_guess
    loop do
      print "Enter a number between #{lowest_value} and #{highest_value}: "
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
    @number = rand(lowest_value..highest_value)
    @guesses = Math.log2(size_of_range).to_i + 1
  end
end

game = GuessingGame.new(501, 1500)
game.play

# You have 10 guesses remaining.
# Enter a number between 501 and 1500: 104
# Invalid guess. Enter a number between 501 and 1500: 1000
# Your guess is too low.

# You have 9 guesses remaining.
# Enter a number between 501 and 1500: 1250
# Your guess is too low.

# You have 8 guesses remaining.
# Enter a number between 501 and 1500: 1375
# Your guess is too high.

# You have 7 guesses remaining.
# Enter a number between 501 and 1500: 80
# Invalid guess. Enter a number between 501 and 1500: 1312
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 501 and 1500: 1343
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 501 and 1500: 1359
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 501 and 1500: 1351
# Your guess is too high.

# You have 3 guesses remaining.
# Enter a number between 501 and 1500: 1355
# That's the number!

# You won!

game.play
# You have 10 guesses remaining.
# Enter a number between 501 and 1500: 1000
# Your guess is too high.

# You have 9 guesses remaining.
# Enter a number between 501 and 1500: 750
# Your guess is too low.

# You have 8 guesses remaining.
# Enter a number between 501 and 1500: 875
# Your guess is too high.

# You have 7 guesses remaining.
# Enter a number between 501 and 1500: 812
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 501 and 1500: 843
# Your guess is too high.

# You have 5 guesses remaining.
# Enter a number between 501 and 1500: 820
# Your guess is too low.

# You have 4 guesses remaining.
# Enter a number between 501 and 1500: 830
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 501 and 1500: 835
# Your guess is too low.

# You have 2 guesses remaining.
# Enter a number between 501 and 1500: 836
# Your guess is too low.

# You have 1 guesses remaining.
# Enter a number between 501 and 1500: 837
# Your guess is too low.

# You have no more guesses. You lost!