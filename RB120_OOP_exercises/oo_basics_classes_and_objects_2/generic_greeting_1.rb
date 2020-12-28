class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting # => Hello! I'm a cat!

#Further Exploration
# What happens if you run `kitty.class.generic_greeting`?
kitty = Cat.new
kitty.class.generic_greeting # => Hello! I'm a cat!

# We output `”Hello! I’m a cat!”` due to our use of method chaining. The return value of `kitty.class` is our class `Cat`. We then call the `generic_greeting` method on our class `Cat`, which outputs the string `”Hello! I’m a cat!”`.

