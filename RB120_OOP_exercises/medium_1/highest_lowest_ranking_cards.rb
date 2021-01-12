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

cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards 
# => 2 of Hearts
# => 10 of Diamonds
# => Ace of Clubs
puts cards.min == Card.new(2, 'Hearts') # => true
puts cards.max == Card.new('Ace', 'Clubs') # => true

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts') # => true
puts cards.max == Card.new(5, 'Hearts') # => true

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4 # => true
puts cards.max == Card.new(10, 'Clubs') # => true

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds') # => true
puts cards.max.rank == 'Jack' # => true

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min.rank == 8 # => true
puts cards.max.rank == 8 # => true

# FURTHER EXPLORATION

class Card
  include Comparable

  RANK_ORDER = (2..10).to_a + %w(Jack Queen King Ace)
  SUIT_ORDER = %w(Diamonds Clubs Hearts Spades)

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other_card)
    if rank == other_card.rank
      SUIT_ORDER.index(suit) <=> SUIT_ORDER.index(other_card.suit)
    else
      RANK_ORDER.index(rank) <=> RANK_ORDER.index(other_card.rank)
    end
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

cards = [Card.new(4, 'Spades'),
         Card.new(4, 'Hearts')]
puts cards.min == Card.new(4, 'Hearts') # => true
puts cards.max == Card.new(4, 'Spades') # => true

cards = [Card.new(4, 'Spades'),
         Card.new(4, 'Hearts'),
         Card.new(4, 'Clubs')]
puts cards.min == Card.new(4, 'Clubs') # => true
puts cards.max == Card.new(4, 'Spades') # => true

cards = [Card.new(4, 'Spades'),
         Card.new(4, 'Hearts'),
         Card.new(4, 'Clubs'),
         Card.new(4, 'Diamonds')]
puts cards.min == Card.new(4, 'Diamonds') # => true
puts cards.max == Card.new(4, 'Spades') # => true

cards = [Card.new(4, 'Spades'),
         Card.new(4, 'Hearts'),
         Card.new(4, 'Clubs'),
         Card.new(4, 'Diamonds'),
         Card.new(5, 'Diamonds')]
puts cards.min == Card.new(4, 'Diamonds') # => true
puts cards.max == Card.new(5, 'Diamonds') # => true


