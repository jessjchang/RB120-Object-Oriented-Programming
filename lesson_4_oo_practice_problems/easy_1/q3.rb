module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

small_car = Car.new
small_car.go_fast
# => I am a Car and going super fast!

# When we called the go_fast method from an instance of the Car class, the string printed when we go fast includes the name of the type of vehicle we are using. How is this done?

# Within the `go_fast` method, we use string interpolation within our output string, and this will call `to_s` automatically on `self.class` and output the return value of this expression as a string. With the expression `self.class`, we are invoking the `#class` method on `self`. `self` refers to the object itself, which is in this case, the `Car` object referenced by local variable `small_car`. By calling `class` on `self`, we will return the class that `small_car` refers to, which is the class `Car` in this case.

