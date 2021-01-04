# What is the default return value of to_s when invoked on an object? Where could you go to find out if you want to be sure?

# The default return value would be the object's class name and an encoding of the object id.
# You could look at Ruby documentation of the Object#to_s method to be sure.

class Dog; end

dog = Dog.new
puts dog # => #<Dog:0x00007faaaa834e68>