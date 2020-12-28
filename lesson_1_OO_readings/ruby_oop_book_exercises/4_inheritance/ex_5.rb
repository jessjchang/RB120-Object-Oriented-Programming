module OffRoadable
  def offroad_drive
    "I have offroad driving capabilities!"
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year, :model

  @@num_vehicles = 0

  def self.num_vehicles
    "There are currently #{@@num_vehicles} vehicles."
  end

  def self.gas_mileage(miles, gallons)
    puts "Gas mileage: #{miles / gallons} miles per gallon"
  end

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@num_vehicles += 1
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

class MyCar < Vehicle
  NUM_SEATS = 5

  def to_s
    "This car is a #{color} #{year} #{model}."
  end
end

class MyTruck < Vehicle
  include OffRoadable

  NUM_SEATS = 2

  def to_s
    "This truck is a #{color} #{year} #{model}."
  end
end

new_car = MyCar.new(2020, 'gray', 'Toyota Camry')
new_car.speed_up(60) # => You are accelerating by 60 miles per hour.
new_car.current_speed # => You are currently driving at 60 miles per hour.
new_car.brake(20) # => You are decelerating by 20 miles per hour.
new_car.current_speed # => You are currently driving at 40 miles per hour.
new_car.brake(20) # => You are decelerating by 20 miles per hour.
new_car.current_speed # => You are currently driving at 20 miles per hour.
new_car.shut_off # => You are now parked.
new_car.current_speed # => You are currently driving at 0 miles per hour.
new_truck = MyTruck.new(2020, 'black', 'Toyota Tacoma')
new_truck.spray_paint('green') # => Your car has now been painted green!
puts new_truck # => This truck is a green 2020 Toyota Tacoma.
