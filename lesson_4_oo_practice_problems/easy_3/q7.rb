class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end

# What is used in this class but doesn't add any value?

# The `return` keyword in the `information` method, because Ruby already automatically returns the return value of the last line executed in a method, so we don't really need an explicit `return` here.