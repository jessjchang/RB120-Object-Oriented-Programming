class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# The `self` within the `make_one_year_older` method refers to the calling object, specifically the instance of the class `Cat` that called the `make_one_year_older` instance method.