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

  def self.gas_mileage(miles, gallons)
    puts "Gas mileage: #{miles / gallons} miles per gallon"
  end

  def to_s
    "This car is a #{color} #{year} #{@model}."
  end
end

new_car = MyCar.new(2020, 'gray', 'Toyota Camry')
puts new_car # => "This car is a gray 2020 Toyota Camry."
