class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# What is the difference in the way the code works?

# There is no difference in terms of the return values, only the way each method will run.
# For the `create_template` method, we're doing the same thing, only in the first example we're directly accessing the `@template` instance variable, and the other we're calling the setter method.
# For the `show_template` method, the `self` in the second example really isn't necessary, because we just want to call the `template` getter method to access the value of the `@template` instance variable, so we don't need the setter method, since we're not reassigning `@template` here.