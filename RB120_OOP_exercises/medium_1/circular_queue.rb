class CircularQueue
  def initialize(buffer_size)
    @max_size = buffer_size
    @queue = Array.new(buffer_size)
    @oldest_index = 0
    @next_index = 0
  end

  def enqueue(value)
    if !queue[next_index].nil?
      self.oldest_index = advance_index(next_index)
    end

    queue[next_index] = value
    self.next_index = advance_index(next_index)
  end

  def dequeue
    value = queue[oldest_index]
    queue[oldest_index] = nil
    self.oldest_index = advance_index(oldest_index) if !value.nil?
    value
  end

  private

  attr_reader :queue, :max_size
  attr_accessor :oldest_index, :next_index

  def advance_index(position)
    (position + 1) % max_size
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil # => true

queue.enqueue(1) 
queue.enqueue(2) 
puts queue.dequeue == 1 # => true 

queue.enqueue(3) 
queue.enqueue(4) 
puts queue.dequeue == 2 # => true

queue.enqueue(5) 
queue.enqueue(6) 
queue.enqueue(7)
puts queue.dequeue == 5 # => true
puts queue.dequeue == 6 # => true
puts queue.dequeue == 7 # => true
puts queue.dequeue == nil # => true

queue = CircularQueue.new(4)
puts queue.dequeue == nil # => true

queue.enqueue(1) 
queue.enqueue(2)
puts queue.dequeue == 1 # => true

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2 # => true

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4 # => true
puts queue.dequeue == 5 # => true
puts queue.dequeue == 6 # => true
puts queue.dequeue == 7 # => true
puts queue.dequeue == nil # => true

# Further Exploration

class CircularQueue
  def initialize(buffer_size)
    @max_size = buffer_size
    @queue = []
  end

  def enqueue(value)
    dequeue if reached_max_size?
    queue.push(value)
  end

  def dequeue
    queue.shift
  end

  private

  attr_reader :queue, :max_size

  def reached_max_size?
    queue.size == max_size
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil # => true

queue.enqueue(1) 
queue.enqueue(2) 
puts queue.dequeue == 1 # => true 

queue.enqueue(3) 
queue.enqueue(4) 
puts queue.dequeue == 2 # => true

queue.enqueue(5) 
queue.enqueue(6) 
queue.enqueue(7)
puts queue.dequeue == 5 # => true
puts queue.dequeue == 6 # => true
puts queue.dequeue == 7 # => true
puts queue.dequeue == nil # => true

queue = CircularQueue.new(4)
puts queue.dequeue == nil # => true

queue.enqueue(1) 
queue.enqueue(2)
puts queue.dequeue == 1 # => true

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2 # => true

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4 # => true
puts queue.dequeue == 5 # => true
puts queue.dequeue == 6 # => true
puts queue.dequeue == 7 # => true
puts queue.dequeue == nil # => true
