class Pet
  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  attr_reader :fur

  def initialize(name, age, fur)
    super(name, age)
    @fur = fur
  end

  def to_s
    "My cat #{name} is #{age} years old and has #{fur} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch 
# => My cat Pudding is 7 years old and has black and white fur.
# => My cat Butterscotch is 10 years old and has tan and white fur.

#Further Exploration
# An alternative approach to this problem would be to modify the Pet class to accept a colors parameter. If we did this, we wouldn't need to supply an initialize method for Cat.

# We would be able to omit the `initialize` method, because then `Pet#new` and `Cats#new` would require the
# same arguments, but we may not want to modify `Pet` in this way, because first off, there may be existing dependencies
# already within our program with the `Pet` class, and modifying the `initialize` method of `Pet` might create 
# problems elsewhere. Another issue might be that color may not be an attribute for some
# types of pets if we wanted to create additional classes that inherited from `Pet`. We could adjust our hierarchy/add new classes
# or modules as well to further organize our colored pets vs. other types of animals. 