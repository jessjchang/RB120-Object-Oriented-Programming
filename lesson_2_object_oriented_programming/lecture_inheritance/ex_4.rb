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

# Method lookup paths:
p Animal.ancestors # => [Animal, Object, Kernel, BasicObject]
p Dog.ancestors # => [Dog, Animal, Object, Kernel, BasicObject]
p Cat.ancestors # => [Cat, Animal, Object, Kernel, BasicObject]
p Bulldog.ancestors # => [Bulldog, Dog, Animal, Object, Kernel, BasicObject]

