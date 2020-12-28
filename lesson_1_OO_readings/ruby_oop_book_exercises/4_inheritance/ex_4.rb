module OffRoadable
  def offroad_drive
    "I have offroad driving capabilities!"
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year
  attr_reader :model

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
new_truck = MyTruck.new(2020, 'black', 'Toyota Tacoma')

puts "---MyCar ancestors---"
puts MyCar.ancestors
=begin
---MyCar ancestors---
MyCar
Vehicle
Object
Kernel
BasicObject
=end

puts "---MyTruck ancestors---"
puts MyTruck.ancestors
=begin
---MyTruck ancestors---
MyTruck
OffRoadable
Vehicle
Object
Kernel
BasicObject
=end

puts "---Vehicle ancestors---"
puts Vehicle.ancestors
=begin
---Vehicle ancestors---
Vehicle
Object
Kernel
BasicObject
=end
