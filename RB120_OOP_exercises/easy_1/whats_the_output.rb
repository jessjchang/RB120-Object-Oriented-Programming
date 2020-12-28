class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name # => 'Fluffy'
puts fluffy # => 'My name is FLUFFY.'
puts fluffy.name # => 'FLUFFY'
puts name # => 'FLUFFY'

#ADJUSTED:
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name # => 'Fluffy'
puts fluffy # => 'My name is FLUFFY.'
puts fluffy.name # => 'Fluffy'
puts name # => 'Fluffy'

# Further Exploration
name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name # => '42'
puts fluffy # => 'My name is 42.'
puts fluffy.name # => '42'
puts name # => 43

# We have a local variable `name` assigned to the integer `42`. Upon instantiating a new `Pet` object and invoking
# the `Pet#initialize` method with `name` passed in as an argument, we've assigned the instance variable `@name` to 
# `42` converted to a `String` object. So when we call `Pet#name`, we return the object referenced by the instance variable `@name`, which
# is the string `'42'`. We can also call the `upcase` method on `@name` with no issue, since `@name` references a 
# string. On `line 44`, we reassign the local variable `name` (initialized on `line 42`) to a new `Integer` object `43`. This doesn't 
# affect our instance variable `@name`, however, since when we converted `42` to a string representation of the integer upon initialization of `@name`,
# `name` and `@name` effectively stopped pointing to the same object in memory. If we wanted to actually change the value of
# `@name`, we could define a setter method within the class, and call it on our `Pet` object referenced by `fluffy` to 
# assign a new value to it.  
