class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end

  def public_disclosure
    "#{self.name} in human years is #{human_years}"
  end

  private

  def human_years
    age * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
sparky.human_years # => NoMethodError: private method `human_years' called for #<GoodDog:0x00007fa12b1100e8 @name="Sparky", @age=4>

p sparky.public_disclosure # => "Sparky in human years is 28"