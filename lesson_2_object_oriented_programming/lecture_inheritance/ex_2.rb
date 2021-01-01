class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Animal
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Animal
  def speak
    'meow!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

annie = Animal.new
spot = Dog.new
socks = Cat.new
billy = Bulldog.new

puts annie.run # => "running!"
puts annie.jump # => "jumping!"
puts annie.speak  # => NoMethodError

puts spot.swim # => "swimming!"
puts spot.fetch # => "fetching!"
puts spot.speak # => "bark!"
puts spot.run # => "running!"

puts socks.speak # => "meow!"
puts socks.jump # => "jumping!"
puts socks.swim  # => NoMethodError

puts billy.speak # => "bark!"
puts billy.run # => "running!"
puts billy.swim # => "can't swim!"
puts billy.fetch # => "fetching!"