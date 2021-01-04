class Cube
  attr_reader :volume

  def initialize(volume)
    @volume = volume
  end
end

cube = Cube.new(50)
p cube.volume # => 50