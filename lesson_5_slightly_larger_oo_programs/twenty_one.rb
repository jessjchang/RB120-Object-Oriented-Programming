module Promptable
  def clear_screen
    system('clear')
  end

  def pause_prompt
    sleep(1)
  end

  def enter_to_continue
    prompt("Press enter to continue with the game.")
    STDIN.gets
  end

  def prompt(message)
    puts "=> #{message}"
    puts "\n"
  end
end

class Hand
  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def add_card(card)
    cards << card
  end

  def total_value
    total = cards.map(&:value).sum
    correct_for_aces(total)
  end

  def display_total
    puts ">> CARD VALUE TOTAL: #{total_value}"
  end

  def display_cards
    cards.each { |card| puts "> #{card}" }
  end

  def display_all_cards_except_one
    if cards.size <= 2
      puts "> #{cards.last}"
    else
      cards[-(cards.size - 1)..-1].each { |card| puts "> #{card}" }
    end
  end

  def <=>(other_hand)
    total_value <=> other_hand.total_value
  end

  private

  def correct_for_aces(total)
    num_aces = cards.select(&:ace?).size
    num_aces.times { total -= 10 if total > Game::WINNING_CARD_VALUE_TOTAL }
    total
  end
end

class Participant
  include Promptable

  attr_accessor :name, :hand

  def initialize
    set_name
  end

  def show_hand
    puts hand_display_header
    hand.display_cards
    hand.display_total
    puts ""
  end

  def hit?
    choice == 'hit'
  end

  def display_hit(card)
    clear_screen
    hand.add_card(card)
    prompt(hit_message)
    enter_to_continue
  end

  def stay?
    choice == 'stay'
  end

  def display_stay
    clear_screen
    prompt(stay_display_message)
    enter_to_continue
  end

  def busted?
    hand.total_value > Game::WINNING_CARD_VALUE_TOTAL
  end

  def display_busted
    clear_screen
    prompt(busted_message)
    enter_to_continue
  end

  def see_rules?
    choice == 'rules'
  end

  private

  attr_accessor :choice

  def hand_display_header
    "--- #{name_display_possessive} HAND ---"
  end

  def valid_choice?(input)
    %w(hit h stay s rules r).include?(input)
  end

  def hit_message
    <<~MSG
    #{self} chose to hit!
    > The next card drawn is: #{hand.cards.last}.
    MSG
  end

  def busted_message
    <<~MSG
    Oh no, #{name_display_possessive} card value total of #{hand.total_value} now exceeds #{Game::WINNING_CARD_VALUE_TOTAL}.
    > Looks like #{self} busted!
    MSG
  end

  def stay_display_message
    "#{self} chose to stay"
  end
end

class Player < Participant
  def to_s
    "YOU"
  end

  def name_display_possessive
    "#{self}R"
  end

  def set_choice
    input = ''
    loop do
      prompt(choice_message)
      input = gets.chomp.downcase
      if valid_choice?(input)
        self.choice = translate_choice(input)
        break
      end
      prompt("Sorry, that's not a valid choice.")
    end
  end

  private

  def valid_name?(input)
    /\A[[:alpha:]]*[[:blank:]]?([[:alpha:]]+)\z/.match(input)
  end

  def set_name
    clear_screen
    n = ''
    loop do
      prompt("Enter your name:")
      n = gets.chomp
      break if valid_name?(n)
      prompt("Please use a valid name (alphabetic characters only).")
    end
    self.name = n
  end

  def choice_message
    <<~MSG
    Please choose to '(h)it' or '(s)tay'. 
    > Enter '(r)ules' if you'd like a refresher on the game rules.
    MSG
  end

  def translate_choice(input)
    case input
    when 'h', 'hit' then 'hit'
    when 's', 'stay' then 'stay'
    when 'r', 'rules' then 'rules'
    end
  end

  def stay_display_message
    super + " at a card value total of #{hand.total_value}."
  end
end

class Dealer < Participant
  attr_reader :hit_limit

  def initialize
    @dealer_locale = [Bellagio.new, MonteCarlo.new,
                      Venetian.new, Caesar.new, Wynn.new].sample
    super
    @hit_limit = dealer_locale.dealer_hit_limit
  end

  def to_s
    name.upcase
  end

  def name_display_possessive
    "#{self}'S"
  end

  def show_all_cards_except_one
    puts hand_display_header
    hand.display_all_cards_except_one
    puts "> ??? (mystery card not visible to you)"
    puts ""
  end

  def set_choice
    self.choice = reached_hit_limit? ? 'stay' : 'hit'
  end

  protected

  attr_reader :title, :start_limit_difference
  attr_accessor :end_limit_difference

  def dealer_hit_limit
    self.end_limit_difference = start_limit_difference if !end_limit_difference
    start_limit = Game::WINNING_CARD_VALUE_TOTAL - start_limit_difference
    end_limit = Game::WINNING_CARD_VALUE_TOTAL - end_limit_difference
    (start_limit..end_limit).to_a.sample
  end

  private

  attr_reader :dealer_locale

  def set_name
    self.name = 'Dealer ' + dealer_locale.title
  end

  def reached_hit_limit?
    hand.total_value >= hit_limit
  end

  def stay_display_message
    super + "."
  end
end

class Bellagio < Dealer
  def initialize
    @title = 'Bellagio'
    @start_limit_difference = 4
  end
end

class MonteCarlo < Dealer
  def initialize
    @title = 'Monte Carlo'
    @start_limit_difference = 2
  end
end

class Venetian < Dealer
  def initialize
    @title = 'Venetian'
    @start_limit_difference = 6
  end
end

class Caesar < Dealer
  def initialize
    @title = 'Caesar'
    @start_limit_difference = 6
    @end_limit_difference = 1
  end
end

class Wynn < Dealer
  def initialize
    @title = 'Wynn'
    @start_limit_difference = 4
    @end_limit_difference = 2
  end
end

class Deck
  def initialize
    @cards = []
    set_cards
  end

  def draw_card
    cards.shift
  end

  def initial_deal
    initial_cards = []
    2.times { initial_cards << draw_card }
    initial_cards
  end

  private

  attr_accessor :cards

  def set_cards
    Card::SUITS.each do |suit|
      Card::FACES.each do |face|
        cards << Card.new(suit, face)
      end
    end
    shuffle_cards
  end

  def shuffle_cards
    cards.shuffle!
  end
end

class Card
  SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
  FACES = [2, 3, 4, 5, 6, 7, 8, 9, 10,
           'Jack', 'Queen', 'King', 'Ace']

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "#{face} of #{suit}"
  end

  def ace?
    face == 'Ace'
  end

  def value
    case face
    when 2..10 then face
    when 'Jack', 'Queen', 'King' then 10
    when 'Ace' then 11
    end
  end

  private

  attr_reader :suit, :face
end

class Game
  include Promptable

  WINNING_CARD_VALUE_TOTAL = 21

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    display_welcome_message
    display_rules
    main_game
    display_goodbye_message
  end

  private

  attr_reader :player, :dealer, :deck
  attr_accessor :winner

  def main_game
    loop do
      display_initial_deal
      full_participant_turn(player)
      full_participant_turn(dealer) unless player.busted?
      display_final_hands
      determine_winner
      display_winner
      break unless replay?
      reset
    end
  end

  def welcome_message
    <<~MSG
    Welcome to Twenty-One, #{player.name}!
    > You will be playing against #{dealer.name}.
    > Let's play!
    MSG
  end

  def display_welcome_message
    clear_screen
    prompt(welcome_message)
    enter_to_continue
  end

  def goal_message
    <<~MSG
    THE GOAL:
    > Get your card value total as close to #{WINNING_CARD_VALUE_TOTAL} as possible without going over.
    MSG
  end

  def display_goal_message
    prompt(goal_message)
    enter_to_continue
  end

  def card_values_message
    <<~MSG
    CARD VALUES:
    > 2-10: face value
    > Jack, Queen, or King: 10
    > Ace: 1 or 11 depending on card value total (11 if total doesn't exceed #{WINNING_CARD_VALUE_TOTAL}, otherwise 1)
    MSG
  end

  def display_card_values_message
    clear_screen
    prompt(card_values_message)
    enter_to_continue
  end

  def gameplay_message_first_half
    <<~MSG
    GAMEPLAY:
    1. #{player} and #{dealer} will each be dealt 2 cards from a shuffled 52-card deck.
    2. #{player} will take the first turn. At each turn, #{player} may choose to 'hit' or 'stay'. 
    3. If #{player} 'hit', another card from the deck will be drawn, and #{player} will again be asked to 'hit' or 'stay'.
    4. #{player} may continue to 'hit' until #{player} either 'bust' or choose to 'stay'.
    MSG
  end

  def gameplay_message_second_half
    <<~MSG
    5. If #{player} 'bust' (i.e. card value total exceeds #{WINNING_CARD_VALUE_TOTAL}), #{dealer} wins the round.
    6. If #{player} 'stay' before busting, it will be #{dealer.name_display_possessive} turn.
    7. #{dealer} must 'hit' until their cards add up to at least #{dealer.hit_limit}.
    8. If #{dealer} 'busts', #{player} win the round.
    9. If #{dealer} 'stays' before busting, the highest card value total wins.
    MSG
  end

  def gameplay_message
    gameplay_message_first_half + gameplay_message_second_half
  end

  def display_gameplay_message
    clear_screen
    prompt(gameplay_message)
    enter_to_continue
  end

  def display_rules
    clear_screen
    prompt("Here are the rules:")
    display_goal_message
    display_card_values_message
    display_gameplay_message
  end

  def initial_hands
    player.hand = Hand.new(deck.initial_deal)
    dealer.hand = Hand.new(deck.initial_deal)
  end

  def initial_deal_message
    <<~MSG
    Cards have been shuffled.
    > This is the initial deal:
    MSG
  end

  def display_initial_deal
    initial_hands
    clear_screen
    prompt(initial_deal_message)
    player.show_hand
    dealer.show_all_cards_except_one
    enter_to_continue
  end

  def hands_display_header
    "#{player.name_display_possessive}S "\
    "AND #{dealer.name_display_possessive} HANDS:"
  end

  def display_player_turn_hands
    clear_screen
    prompt(hands_display_header)
    player.show_hand
    dealer.show_all_cards_except_one
    enter_to_continue
  end

  def display_participant_hit(participant)
    card = deck.draw_card
    participant.display_hit(card)
    display_player_turn_hands unless participant.busted?
  end

  def display_participant_rules_choice_messages
    display_rules
    display_player_turn_hands
  end

  def participant_turn(participant)
    loop do
      break if participant.busted?
      participant.set_choice
      break if participant.stay?
      display_participant_hit(participant) if participant.hit?
      display_participant_rules_choice_messages if participant.see_rules?
    end
  end

  def display_next_step_after_stay(participant)
    case participant
    when player
      prompt("#{dealer.name_display_possessive} turn now...")
    when dealer
      prompt("Let's compare hands...")
    end
    enter_to_continue
  end

  def display_participant_outcome(participant)
    if participant.busted?
      participant.display_busted
      prompt("Let's take a look at the final hands...")
      enter_to_continue
    else
      participant.display_stay
      display_next_step_after_stay(participant)
    end
  end

  def full_participant_turn(participant)
    participant_turn(participant)
    display_participant_outcome(participant)
  end

  def display_final_hands
    clear_screen
    prompt(hands_display_header)
    player.show_hand
    puts ""
    dealer.show_hand
    enter_to_continue
  end

  def compare_hands_winner
    case player.hand <=> dealer.hand
    when -1 then dealer
    when 0 then 'tie'
    when 1 then player
    end
  end

  def determine_winner
    self.winner = if player.busted?
                    dealer
                  elsif dealer.busted?
                    player
                  else
                    compare_hands_winner
                  end
  end

  def display_winner
    clear_screen
    prompt("That means the outcome of this game is...")
    pause_prompt
    if winner == 'tie'
      prompt("It's a tie!")
    else
      prompt("The winner is #{winner}!")
    end
    enter_to_continue
  end

  def replay_message
    <<~MSG
    Would you like to play again?
    > Enter 'Y' to play again / 'N' to quit
    MSG
  end

  def replay?
    clear_screen
    prompt(replay_message)

    replay_input = nil
    loop do
      replay_input = gets.chomp.downcase
      break if %w(y yes n no).include?(replay_input)
      prompt("Must enter 'Y' for yes or 'N' for no.")
    end

    ['y', 'yes'].include?(replay_input)
  end

  def new_dealer_message
    <<~MSG
    Your new dealer will be #{dealer}.
    > #{dealer} must 'hit' until their cards add up to at least #{dealer.hit_limit}.
    > Let's play!
    MSG
  end

  def display_new_dealer
    @dealer = Dealer.new
    prompt(new_dealer_message)
  end

  def reset
    clear_screen
    @deck = Deck.new
    display_new_dealer
    enter_to_continue
  end

  def display_goodbye_message
    prompt("Thank you for playing Twenty-One! Goodbye!")
  end
end

Game.new.start
