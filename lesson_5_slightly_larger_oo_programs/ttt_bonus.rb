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

class Board
  include Promptable

  MARKING_ROW_SPACES = 2
  BLANK_ROW_SPACES = 5

  attr_accessor :size, :winning_lines

  def initialize
    @squares = {}
    set_size
    set_winning_lines
    reset_squares
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def all_unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    all_unmarked_keys.empty?
  end

  def winning_marker
    winning_lines.each do |line|
      squares = @squares.values_at(*line)
      if all_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset_squares
    (1..(size**2)).each { |key| @squares[key] = Square.new }
  end

  def draw
    key = 1
    size.times do |row|
      puts whitespace_row
      puts row_markings(key)
      puts whitespace_row
      puts border_row if row != size - 1
      key += size
    end
  end

  def winning_line_key(target_marker)
    winning_lines.each do |line|
      key = key_to_win(target_marker, line)
      return key if key
    end
    nil
  end

  def block_win_key(target_marker)
    winning_lines.each do |line|
      key = key_to_lose(target_marker, line)
      return key if key
    end
    nil
  end

  def best_offensive_key(target_marker)
    best_offensive_line = nil
    winning_lines.each do |line|
      moves = offensive_moves(target_marker, line)
      if !best_offensive_line && moves
        best_offensive_line = moves
      elsif moves && moves.size < best_offensive_line.size
        best_offensive_line = moves
      end
    end
    best_offensive_line&.sample
  end

  def center_key
    ((size**2) / 2) + 1
  end

  def center_square_marked?
    @squares[center_key].marked?
  end

  def random_key
    all_unmarked_keys.sample
  end

  private

  def valid_size?(num)
    /\A[+]?\d+\z/.match(num) && num.to_i.odd? && num.to_i >= 3 && num.to_i <= 31
  end

  def choose_size_message
    <<~MSG
    Please enter the size of the board you'd like to play on.
    > Enter an odd integer that will denote the number of rows/columns of the board.
    > For example, if you'd like to play on a 3 x 3 board, enter '3'.
    > Board size can be between 3 and 31.
    MSG
  end

  def invalid_size_message
    <<~MSG
    Sorry, that's not a valid board size.
    > Please enter an odd integer greater than or equal to 3 and less than or equal to 31:
    MSG
  end

  def set_size
    clear_screen
    prompt(choose_size_message)
    answer = ''
    loop do
      answer = gets.chomp
      break if valid_size?(answer)
      prompt(invalid_size_message)
    end
    self.size = answer.to_i
  end

  def find_winning_rows
    total_keys = size**2
    (1..total_keys).each_slice(size).to_a
  end

  def find_winning_cols
    1.upto(size).with_object([]) do |count, winning_cols|
      single_winning_col = []
      next_column_key = count
      while single_winning_col.size < size
        single_winning_col << next_column_key
        next_column_key += size
      end
      winning_cols << single_winning_col
    end
  end

  def winning_diagonal_starting_key(start)
    case start
    when 'left' then 1
    when 'right' then size
    end
  end

  def winning_diagonal_increment(start)
    case start
    when 'left' then size + 1
    when 'right' then size - 1
    end
  end

  def find_winning_diagonal(start)
    winning_diagonal = []
    key = winning_diagonal_starting_key(start)
    size.times do
      winning_diagonal << key
      key += winning_diagonal_increment(start)
    end
    [winning_diagonal]
  end

  def find_winning_lines
    find_winning_rows +
      find_winning_cols +
      find_winning_diagonal('left') +
      find_winning_diagonal('right')
  end

  def set_winning_lines
    self.winning_lines = find_winning_lines
  end

  def markings_square(key)
    "#{' ' * MARKING_ROW_SPACES}#{@squares[key]}#{' ' * MARKING_ROW_SPACES}"
  end

  def whitespace_row
    whitespace_row = ''
    (size - 1).times { whitespace_row << "#{' ' * BLANK_ROW_SPACES}|" }
    whitespace_row
  end

  def row_markings(key)
    marking_row = ''
    size.times do |col|
      marking_row << if col == size - 1
                       markings_square(key)
                     else
                       markings_square(key) + '|'
                     end
      key += 1
    end
    marking_row
  end

  def border_row
    border_row = ''
    size.times do |col|
      border_row << if col == size - 1
                      '-' * BLANK_ROW_SPACES
                    else
                      "#{'-' * BLANK_ROW_SPACES}+"
                    end
    end
    border_row
  end

  def all_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != size
    no_mixed_markers?(markers)
  end

  def all_identical_with_one_empty?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != (size - 1)
    no_mixed_markers?(markers)
  end

  def offensive_unmarked_keys(line)
    all_unmarked_keys.select { |key| line.include?(key) }
  end

  def only_unmarked_key(line)
    all_unmarked_keys.find { |key| line.include?(key) }
  end

  def key_to_win(target_marker, line)
    squares = @squares.values_at(*line)
    markers = squares.select(&:marked?).collect(&:marker)
    return unless all_identical_with_one_empty?(squares) &&
                  markers.include?(target_marker)
    only_unmarked_key(line)
  end

  def key_to_lose(target_marker, line)
    squares = @squares.values_at(*line)
    markers = squares.select(&:marked?).collect(&:marker)
    return unless all_identical_with_one_empty?(squares) &&
                  !markers.include?(target_marker)
    only_unmarked_key(line)
  end

  def no_mixed_markers?(markers)
    markers.uniq.size == 1
  end

  def offensive_moves(target_marker, line)
    squares = @squares.values_at(*line)
    markers = squares.select(&:marked?).collect(&:marker)
    return unless markers.count(target_marker) >= 1 &&
                  no_mixed_markers?(markers)
    offensive_unmarked_keys(line)
  end
end

class RuleBoard < Board
  def initialize(size)
    @size = size
  end

  private

  def markings_square(key)
    case key.digits.size
    when 1
      "#{' ' * MARKING_ROW_SPACES}#{key}#{' ' * MARKING_ROW_SPACES}"
    when 2
      "#{' ' * MARKING_ROW_SPACES}#{key}#{' ' * (MARKING_ROW_SPACES - 1)}"
    when 3
      "#{' ' * (MARKING_ROW_SPACES - 1)}#{key}#{' ' * (MARKING_ROW_SPACES - 1)}"
    end
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  include Promptable

  @@markers = []
  @@names = []

  attr_accessor :score, :name, :marker

  def initialize
    @score = 0
    set_name
  end

  def self.markers=(markers)
    @@markers = markers
  end

  def self.names
    @@names
  end

  def set_marker
    clear_screen
    prompt(choose_marker_message)
    self.marker = marker_input
    @@markers << marker
  end

  private

  attr_accessor :choice

  def repeat_marker?(input)
    @@markers.include?(input)
  end

  def repeat_marker_message
    <<~MSG
    You and the Computer cannot have the same marker.
    > One marker has already been set as #{@@markers.first}.
    MSG
  end

  def valid_marker_input?(input)
    (/^[\S]{1}$/.match(input) || input.downcase == 'default') &&
      !repeat_marker?(input)
  end

  def invalid_marker_message
    <<~MSG
    Please try again with a valid marker.
    > Enter a singular non-space character.
    > Or, you may enter 'Default' to use the default marker of '#{self.class::DEFAULT_MARKER}'.
    MSG
  end

  def confirmed_input_if_valid(input)
    if input.downcase == 'default'
      self.class::DEFAULT_MARKER
    else
      input
    end
  end

  def marker_input
    input = nil
    loop do
      input = gets.chomp
      return confirmed_input_if_valid(input) if valid_marker_input?(input)
      prompt(repeat_marker_message) if repeat_marker?(input)
      prompt(invalid_marker_message)
    end
  end
end

class Human < Player
  DEFAULT_MARKER = 'X'

  def move(board)
    input = choice_input(board)
    return 'rules' if input == 'rules'
    self.choice = input
    board[choice] = marker
  end

  private

  def valid_name?(name)
    /\A[[:alpha:]]*[[:blank:]]?([[:alpha:]]+)\z/.match(name)
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
    @@names << name
  end

  def choose_marker_message
    <<~MSG
    First, please enter any marker you'd like to play with (singular non-space character only).
    > You may enter 'Default' to use your default marker of '#{DEFAULT_MARKER}'.
    MSG
  end

  def joinor(keys_arr, delimiter=', ', joining_word='or')
    case keys_arr.size
    when 1 then keys_arr.first
    when 2 then "#{keys_arr.first} #{joining_word} #{keys_arr.last}"
    else
      keys_arr[-1] = "#{joining_word} #{keys_arr.last}"
      keys_arr.join(delimiter)
    end
  end

  def valid_choice?(input, board)
    /\A[+]?\d+\z/.match(input) && board.all_unmarked_keys.include?(input.to_i)
  end

  def choice_message(board)
    <<~MSG
    Choose a position number from this list of open squares: #{joinor(board.all_unmarked_keys)}
    > Enter 'rules' if you'd like a refresher on the rules and board positions.
    MSG
  end

  def choice_input(board)
    loop do
      prompt(choice_message(board))
      input = gets.chomp
      return input.to_i if valid_choice?(input, board)
      return 'rules' if input.downcase == 'rules'
      prompt("Sorry, that's not a valid choice.")
      pause_prompt
    end
  end
end

class Computer < Player
  DEFAULT_MARKER = 'O'

  def move(board)
    self.choice = nil
    self.choice = key_choice(board, marker)
    board[choice] = marker
  end

  private

  def set_name
    n = nil
    loop do
      n = ['WALL-E', 'HAL 9000', 'Terminator', 'C3PO', 'TARS'].sample
      break if !@@names.include?(n)
    end
    self.name = n
    @@names << name
  end

  def choose_marker_message
    <<~MSG
    Now, please enter any marker you'd like #{name} to play with (singular non-space character only).
    > You may enter 'Default' to use #{name}'s default marker of '#{DEFAULT_MARKER}'.
    MSG
  end

  def key_choice(board, target_marker)
    choice ||= board.winning_line_key(target_marker)
    choice ||= board.block_win_key(target_marker)
    choice ||= board.best_offensive_key(target_marker)
    choice ||= board.center_key unless board.center_square_marked?
    choice ||= board.random_key
    choice
  end
end

class TTTGame
  include Promptable

  WINNING_SCORE = 5
  FIRST_TO_MOVE = 'choose' # can be set to 'human', 'computer', or 'choose'

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def play
    display_welcome_message
    loop do
      initial_settings
      main_game
      display_grand_winner
      break unless replay?
      reset_match
    end
    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer
  attr_accessor :current_marker

  def main_game
    loop do
      display_round_start
      player_move
      display_round_result
      display_current_score
      display_match_status
      break if match_over?
      reset_round
    end
  end

  def player_move
    loop do
      current_player_moves
      break if someone_won_round? || board.full?
      display_board if human_turn?
    end
  end

  def welcome_message
    <<~MSG
    Welcome to Tic Tac Toe, #{human.name}!
    > You will be playing against #{computer.name}.
    > Let's play!
    MSG
  end

  def display_welcome_message
    clear_screen
    prompt(welcome_message)
    enter_to_continue
  end

  def initial_settings
    set_player_markers
    set_board
    display_rules
    set_current_marker
  end

  def set_player_markers
    human.set_marker
    computer.set_marker
  end

  def set_board
    @board = Board.new
  end

  def rules_message
    <<~MSG
    Here are the rules:
    > Your marker is #{human.marker}. #{computer.name}'s marker is #{computer.marker}.
    > You will each alternate moves, and whoever successfully places their marker in every square of a single row, column, or diagonal first wins the round.
    > The first to win #{WINNING_SCORE} rounds will be the grand winner of the match!
    > The numbered positions of each square on the board are as follows:
    MSG
  end

  def display_rule_board_positions
    @rule_board = RuleBoard.new(board.size)
    puts ""
    @rule_board.draw
    puts ""
  end

  def display_rules
    clear_screen
    prompt(rules_message)
    display_rule_board_positions
    enter_to_continue
  end

  def valid_starting_player_input?(input)
    ['y', 'yes', 'n', 'no', 'random', 'r'].include?(input.downcase)
  end

  def choose_starting_player_message
    <<~MSG
    Would you like to make the first move in the match?
    > Enter 'Y' if you want to move first.
    > Enter 'N' if you want #{computer.name} to move first.
    > Enter 'Random' if you want the starting player to be chosen at random.
    MSG
  end

  def invalid_starting_player_input
    "Must enter 'Y' for yes, 'N' for no, or 'Random' to choose at random."
  end

  def prompt_starting_player
    clear_screen
    prompt(choose_starting_player_message)
    input = ''
    loop do
      input = gets.chomp
      break if valid_starting_player_input?(input)
      prompt(invalid_starting_player_input)
    end
    input.downcase
  end

  def starting_player
    case prompt_starting_player
    when 'y', 'yes' then human
    when 'n', 'no' then computer
    else [human, computer].sample
    end
  end

  def set_current_marker
    self.current_marker = case FIRST_TO_MOVE
                          when 'choose' then starting_player.marker
                          when 'human' then human.marker
                          when 'computer' then computer.marker
                          end
  end

  def display_starting_player
    clear_screen
    if current_marker == human.marker
      prompt("You will go first in this round.")
    else
      prompt("#{computer.name} will go first in this round.")
    end
    enter_to_continue
  end

  def display_board_message
    <<~MSG
    Here is the current board.
    > Your marker is #{human.marker}.
    > #{computer.name}'s marker is #{computer.marker}.
    MSG
  end

  def display_board
    clear_screen
    prompt(display_board_message)
    puts ""
    board.draw
    puts ""
  end

  def display_round_start
    display_starting_player
    display_board
  end

  def alternate_marker
    self.current_marker = if human_turn?
                            computer.marker
                          else
                            human.marker
                          end
  end

  def current_player_moves
    if human_turn?
      loop do
        break if human.move(board) != 'rules'
        display_rules
        display_board
      end
    else
      computer.move(board)
    end
    alternate_marker
  end

  def human_turn?
    current_marker == human.marker
  end

  def someone_won_round?
    !!board.winning_marker
  end

  def display_round_result
    display_board

    case board.winning_marker
    when human.marker
      prompt("You won this round!")
    when computer.marker
      prompt("#{computer.name} won this round!")
    else
      prompt("It's a tie!")
    end

    enter_to_continue
  end

  def update_score
    case board.winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
    end
  end

  def current_score_display
    <<~MSG
    The current point standings are:
    > You: #{human.score}
    > #{computer.name}: #{computer.score}
    MSG
  end

  def display_current_score
    update_score
    clear_screen
    prompt(current_score_display)
    enter_to_continue
  end

  def match_over?
    human.score == WINNING_SCORE || computer.score == WINNING_SCORE
  end

  def match_status_message
    if match_over?
      "That's #{WINNING_SCORE} rounds won! "\
      "Looks like we've found our grand winner..."
    else
      "Game's not over yet! "\
      "Remember, the first to #{WINNING_SCORE} points wins. "\
      "On to the next round..."
    end
  end

  def display_match_status
    clear_screen
    prompt(match_status_message)
    enter_to_continue
  end

  def display_grand_winner
    clear_screen
    if human.score == WINNING_SCORE
      prompt("You are the grand winner of this match!")
    else
      prompt("#{computer.name} is the grand winner of this match!")
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

  def display_goodbye_message
    prompt("Thank you for playing Tic Tac Toe! Goodbye!")
  end

  def display_new_computer
    @computer = Computer.new

    prompt("Your opponent for this match will be #{computer.name}. Let's play!")
    enter_to_continue
  end

  def reset_round
    board.reset_squares
  end

  def reset_match
    clear_screen
    display_new_computer
    human.score = 0
    Player.markers = []
    Player.names.pop
  end
end

game = TTTGame.new
game.play
