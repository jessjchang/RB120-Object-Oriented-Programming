class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

bruno = GoodDog.new("brown")
p bruno # => #<GoodDog:0x00007feb6f138140 @name="brown", @color="brown">

p BadDog.new(2, "bear") # => #<BadDog:0x00007f98e993b960 @name="bear", @age=2>