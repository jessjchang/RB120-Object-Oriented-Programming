class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super()
    @color = color
  end
end

bear = Bear.new("black")
p bear # => #<Bear:0x00007fa19392c2c8 @color="black">