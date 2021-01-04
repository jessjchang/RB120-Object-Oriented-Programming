class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# Which of these two classes has an instance variable and how do you know?

# The class `Pizza` has an instance variable `@name`. This variable begins with the `@` symbol, which signifies an instance variable.

# To confirm, we can call the `instance_variables` method on instances of these classes:

pepperoni_pizza = Pizza.new('pepperoni')
p pepperoni_pizza.instance_variables # => [:@name]
# The `Pizza` class has an instance variable `@name`

banana = Fruit.new('banana')
p banana.instance_variables # => []
# The `Fruit` class does not have any instance variables

