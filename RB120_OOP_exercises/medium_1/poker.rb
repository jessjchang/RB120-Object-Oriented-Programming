# Include Card and Deck classes from the last two exercises.

class PokerHand
  def initialize(deck)
    @cards = []
    @count_of_ranks = Hash.new(0)
    reset(deck)
  end

  def print
    puts cards
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  attr_reader :cards, :count_of_ranks

  def reset(deck)
    5.times do
      card = deck.draw
      cards << card
      count_of_ranks[card.rank] += 1
    end
  end

  def same_suit?(card, suit)
    card.suit == suit
  end

  def royal_flush?
    straight_flush? && cards.min.rank == 10
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    count_of_ranks.any? { |_, count| count == 4 }
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
    same_suit_test = cards.first.suit
    cards.all? { |card| same_suit?(card, same_suit_test) }
  end

  def straight?
    return false if count_of_ranks.any? { |_, count| count > 1 }
    cards.min.value == cards.max.value - 4
  end

  def three_of_a_kind?
    count_of_ranks.any? { |_, count| count == 3 }
  end

  def two_pair?
    count_of_ranks.select { |_, count| count == 2 }.size == 2
  end

  def pair?
    count_of_ranks.any? { |_, count| count == 2 }
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @cards = []
    reset
  end

  def shuffle
    cards.shuffle!
  end

  def draw
    reset if cards.empty?
    cards.shift
  end

  private

  attr_reader :cards

  def reset
    RANKS.each do |rank|
      SUITS.each do |suit|
        cards << Card.new(rank, suit)
      end
    end

    shuffle
  end
end

class Card
  include Comparable
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other_card)
    value <=> other_card.value
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    case rank
    when 'Jack' then 11
    when 'Queen' then 12
    when 'King' then 13
    when 'Ace' then 14
    else rank
    end
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush' # => true

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush' # => true

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind' # => true

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house' # => true

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush' # => true

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight' # => true

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight' # => true

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind' # => true

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair' # => true

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair' # => true

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card' # => true

# FURTHER EXPLORATION
# How would you modify this class if you wanted the individual classification methods (royal_flush?, straight?, three_of_a_kind?, etc) to be public class methods that work with an an Array of 5 cards, e.g.,
# def self.royal_flush?(cards)
#   ...
# end

class PokerHand
  def self.init(cards)
    @cards = cards
    @count_of_ranks = Hash.new(0)
    set_count_of_ranks
  end

  def self.royal_flush?(cards)
    init(cards)
    straight_flush?(cards) && @cards.min.rank == 10
  end

  def self.straight_flush?(cards)
    init(cards)
    flush?(cards) && straight?(cards)
  end

  def self.four_of_a_kind?(cards)
    init(cards)
    @count_of_ranks.any? { |_, count| count == 4 }
  end

  def self.full_house?(cards)
    init(cards)
    three_of_a_kind?(cards) && pair?(cards)
  end

  def self.flush?(cards)
    init(cards)
    same_suit_test = @cards.first.suit
    @cards.all? { |card| same_suit?(card, same_suit_test) }
  end

  def self.straight?(cards)
    init(cards)
    return false if @count_of_ranks.any? { |_, count| count > 1 }
    @cards.min.value == @cards.max.value - 4
  end

  def self.three_of_a_kind?(cards)
    init(cards)
    @count_of_ranks.any? { |_, count| count == 3 }
  end

  def self.two_pair?(cards)
    init(cards)
    @count_of_ranks.select { |_, count| count == 2 }.size == 2
  end

  def self.pair?(cards)
    init(cards)
    @count_of_ranks.any? { |_, count| count == 2 }
  end

  def self.high_card?(cards)
    init(cards)
    !straight_flush?(cards) &&
    !four_of_a_kind?(cards) &&
    !full_house?(cards) &&
    !flush?(cards) &&
    !straight?(cards) &&
    !three_of_a_kind?(cards) &&
    !two_pair?(cards) &&
    !pair?(cards)
  end

  private

  def self.set_count_of_ranks
    @cards.each { |card| @count_of_ranks[card.rank] += 1 }
  end

  def self.same_suit?(card, suit)
    card.suit == suit
  end
end

class Card
  include Comparable
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other_card)
    value <=> other_card.value
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    case rank
    when 'Jack' then 11
    when 'Queen' then 12
    when 'King' then 13
    when 'Ace' then 14
    else rank
    end
  end
end

p PokerHand.royal_flush?([
    Card.new(10,      'Hearts'),
    Card.new('Ace',   'Hearts'),
    Card.new('Queen', 'Hearts'),
    Card.new('King',  'Hearts'),
    Card.new('Jack',  'Hearts')
  ]) # => true

p PokerHand.straight_flush?([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
]) # => true

p PokerHand.four_of_a_kind?([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
]) # => true

p PokerHand.full_house?([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
]) # => true

p PokerHand.flush?([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
]) # => true

p PokerHand.straight?([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
]) # => true

p PokerHand.three_of_a_kind?([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
]) # => true

p PokerHand.two_pair?([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
]) # => true

p PokerHand.pair?([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
]) # => true

p PokerHand.high_card?([
    Card.new(2,      'Hearts'),
    Card.new('King', 'Clubs'),
    Card.new(5,      'Diamonds'),
    Card.new(9,      'Spades'),
    Card.new(3,      'Diamonds')
]) # => true