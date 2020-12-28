class GoodDog
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def name=(n)
    @name = n
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak # => "Sparky says arf!"
puts sparky.name # => "Sparky"
sparky.name = "Spartacus"
puts sparky.name # => "Spartacus"

fido = GoodDog.new("Fido")
puts fido.speak # => "Fido says arf!"