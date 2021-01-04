class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# case 1:
hello = Hello.new
hello.hi # => 'Hello'

# case 2:
hello = Hello.new
hello.bye # => NoMethodError: undefined method `bye' for #<Hello:0x00007fcb2b04fb48>

# case 3:
hello = Hello.new
hello.greet # => ArgumentError: wrong number of arguments (given 0, expected 1)

# case 4:
hello = Hello.new
hello.greet("Goodbye") # => 'Goodbye'

# case 5:
Hello.hi # => NoMethodError: undefined method `hi' for Hello:Class