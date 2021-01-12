class FixedArray
  def initialize(size)
    @arr = Array.new(size)
  end

  def [](index)
    arr.fetch(index)
  end

  def []=(index, value)
    self[index]
    arr[index] = value
  end

  def to_a
    arr.dup
  end

  def to_s
    to_a.to_s
  end

  private

  attr_reader :arr
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil # => true
puts fixed_array.to_a == [nil] * 5 # => true

fixed_array[3] = 'a'
puts fixed_array[3] == 'a' # => true
puts fixed_array.to_a == [nil, nil, nil, 'a', nil] # => true

fixed_array[1] = 'b'
puts fixed_array[1] == 'b' # => true
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil] # => true

fixed_array[1] = 'c'
puts fixed_array[1] == 'c' # => true
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil] # => true

fixed_array[4] = 'd'
puts fixed_array[4] == 'd' # => true
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd'] # => true
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]' # => true

puts fixed_array[-1] == 'd' # => true
puts fixed_array[-4] == 'c' # => true

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true # => true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true # => true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true # => true
end