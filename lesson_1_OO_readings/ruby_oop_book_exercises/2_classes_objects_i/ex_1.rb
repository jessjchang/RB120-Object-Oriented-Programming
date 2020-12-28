class MyCar

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
end

new_car = MyCar.new(2020, 'gray', 'Toyota Camry')
new_car.speed_up(60) # => 'You are accelerating by 60 miles per hour.'
new_car.current_speed # => 'You are currently driving at 60 miles per hour.'
new_car.brake(20) # => 'You are decelerating by 20 miles per hour.'
new_car.current_speed # => 'You are currently driving at 40 miles per hour.'
new_car.brake(20) # => 'You are decelerating by 20 miles per hour.'
new_car.current_speed # => 'You are currently driving at 20 miles per hour.'
new_car.shut_off # => 'You are now parked.'
new_car.current_speed # => 'You are currently driving at 0 miles per hour.'