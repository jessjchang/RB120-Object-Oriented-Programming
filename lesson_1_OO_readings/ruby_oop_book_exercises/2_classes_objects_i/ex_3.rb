class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up(num)
    @speed += num
    puts "You are accelerating by #{num} miles per hour."
  end

  def brake(num)
    @speed -= num
    puts "You are decelerating by #{num} miles per hour."
  end

  def shut_off
    @speed = 0
    puts "You are now parked."
  end

  def current_speed
    puts "You are currently driving at #{@speed} miles per hour."
  end

  def spray_paint(color)
    self.color = color
    puts "Your car has now been painted #{color}!"
  end
end

new_car = MyCar.new(2020, 'gray', 'Toyota Camry')

puts new_car.color # => 'gray'
new_car.spray_paint('red') # => 'Your car has now been painted red!'
puts new_car.color # => 'red'