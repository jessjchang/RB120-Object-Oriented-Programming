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

# Class hierarchy:
# ----Animal----
# run
# jump

# Subclasses of Animal:
# ---Dog---               ---Cat---
# speak                   speak
# swim
# fetch

# Subclass of Dog:
# ---Bulldog---
# swim

