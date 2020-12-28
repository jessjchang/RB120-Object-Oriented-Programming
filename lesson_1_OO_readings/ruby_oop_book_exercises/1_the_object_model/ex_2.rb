module MakeSound
  def make_sound(sound)
    puts sound
  end
end

class Cat
  include MakeSound
end

socks = Cat.new
socks.make_sound("Meow") #=> Meow

