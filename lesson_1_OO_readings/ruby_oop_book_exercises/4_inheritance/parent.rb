class Parent
  def say_hi
    p "Hi from Parent."
  end
end

class Child < Parent
  def say_hi
    p "Hi from Child."
  end

  def send
    p "send from Child..."
  end

  def instance_of?
    p "I am a fake instance"
  end
end

Parent.superclass # => Object

child = Child.new
child.say_hi # => "Hi from Child."

son = Child.new
# son.send :say_hi # => "Hi from Child."

lad = Child.new
# lad.send :say_hi #after overriding #send method: => ArgumentError: wrong number of arguments (given 1, expected 0)

c = Child.new
c.instance_of? Child # => true
c.instance_of? Parent # => false

heir = Child.new
heir.instance_of? Child #after overriding #instance_of? method: => ArgumentError: wrong number of arguments (given 1, expected 0)