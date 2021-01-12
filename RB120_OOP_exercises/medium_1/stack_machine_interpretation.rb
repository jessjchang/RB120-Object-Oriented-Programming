require 'set'

class MinilangError < StandardError; end
class UnknownTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  COMMANDS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  attr_accessor :register

  def initialize(program_str)
    @program_str = program_str
  end

  def eval
    @stack = []
    @register = 0
    begin
      program_str.split.each { |token| read_token(token) }
    rescue MinilangError => error
      puts error.message
    end
  end

  private

  attr_reader :program_str, :stack

  def read_token(token)
    if COMMANDS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      self.register = token.to_i
    else
      raise UnknownTokenError, "Invalid token: #{token}"
    end
  end

  def push
    stack << register
  end

  def pop
    raise EmptyStackError, "Empty stack!" if stack.empty?
    self.register = stack.pop
  end

  def add
    self.register += pop
  end

  def sub
    self.register -= pop
  end

  def mult
    self.register *= pop
  end

  def div
    self.register /= pop
  end

  def mod
    self.register %= pop
  end

  def print
    puts register
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)

# FURTHER EXPLORATION 1

require 'set'

class MinilangError < StandardError; end
class UnknownTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  COMMANDS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  attr_accessor :register

  def initialize(program_str)
    @program_str = program_str
  end

  def eval(args={})
    @stack = []
    @register = 0
    commands = format(program_str, args).split
    commands.each { |token| read_token(token) }
  rescue MinilangError => error
    puts error.message
  end

  private

  attr_reader :program_str, :stack

  def read_token(token)
    if COMMANDS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      self.register = token.to_i
    else
      raise UnknownTokenError, "Invalid token: #{token}"
    end
  end

  def push
    stack << register
  end

  def pop
    raise EmptyStackError, "Empty stack!" if stack.empty?
    self.register = stack.pop
  end

  def add
    self.register += pop
  end

  def sub
    self.register -= pop
  end

  def mult
    self.register *= pop
  end

  def div
    self.register /= pop
  end

  def mod
    self.register %= pop
  end

  def print
    puts register
  end
end

# Centigrade to Fahrenheit:

CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)
# 212
minilang.eval(degrees_c: 0)
# 32
minilang.eval(degrees_c: -40)
# -40

# Fahrenheit to Centigrade:

FAHRENHEIT_TO_CENTIGRADE = '9 PUSH 5 PUSH 32 PUSH %<degrees_f>d SUB MULT DIV PRINT'

minilang = Minilang.new(FAHRENHEIT_TO_CENTIGRADE)
minilang.eval(degrees_f: 212)
# 100
minilang.eval(degrees_f: 32)
# 0
minilang.eval(degrees_f: -40)
# -40
minilang.eval(degrees_f: 44)
# 6

# mph to kph:
MPH_TO_KPH = '3 PUSH 5 PUSH %<speed_mph>d MULT DIV PRINT'

minilang = Minilang.new(MPH_TO_KPH)
minilang.eval(speed_mph: 3)
# 5
minilang.eval(speed_mph: 100)
# 166
minilang.eval(speed_mph: 50)
# 83
minilang.eval(speed_mph: 75)
# 125

# Area of a rectangle:
AREA_OF_RECTANGLE = '%<rect_height>d PUSH %<rect_base>d MULT PRINT'

minilang = Minilang.new(AREA_OF_RECTANGLE)
minilang.eval(rect_base: 4, rect_height: 8)
# 32
minilang.eval(rect_base: 9, rect_height: 6)
# 54
minilang.eval(rect_base: 23, rect_height: 14)
# 322

# FURTHER EXPLORATION 2

require 'set'

class MinilangError < StandardError; end
class UnknownTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  COMMANDS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  attr_accessor :register

  def initialize(program_str)
    @program_str = program_str
  end

  def eval(args={})
    @stack = []
    @register = 0
    commands = format(program_str, args).split
    commands.each { |token| read_token(token) }
  rescue MinilangError => error
    puts error.message
  end

  private

  attr_reader :program_str, :stack

  def read_token(token)
    if COMMANDS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      self.register = token.to_i
    else
      raise UnknownTokenError, "Invalid token: #{token}"
    end
  end

  def push
    stack << register
  end

  def pop
    raise EmptyStackError, "Empty stack!" if stack.empty?
    self.register = stack.pop
  end

  def add
    original_register = register
    self.register = original_register + pop
  end

  def sub
    original_register = register
    self.register = original_register - pop
  end

  def mult
    original_register = register
    self.register = original_register * pop
  end

  def div
    original_register = register
    self.register = original_register / pop
  end

  def mod
    original_register = register
    self.register = original_register % pop
  end

  def print
    puts register
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
