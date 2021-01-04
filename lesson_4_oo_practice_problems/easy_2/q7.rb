class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# The `@@cats_count` variable is a class variable that will keep track of how many instances of the `Cat` class we have created, because we are incrementing the value of `@@cats_count` within our `Cat` class's `initialize` method, which is called every time we create a new `Cat` instance. 

p Cat.cats_count # => 0
cat1 = Cat.new('tabby')
p Cat.cats_count # => 1
cat2 = Cat.new('black')
p Cat.cats_count # => 2
cat3 = Cat.new('siamese')
p Cat.cats_count # => 3