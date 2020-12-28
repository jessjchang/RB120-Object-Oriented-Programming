class Animal
  def a_public_method
    "Will this work? " + self.a_protected_method
  end

  protected

  def a_protected_method
    "Yes, I'm protected!"
  end
end

fido = Animal.new
fido.a_public_method  # => Will this work? Yes, I'm protected!

fido.a_protected_method # => NoMethodError: protected method `a_protected_method' called for #<Animal:0x00007fa1aa8706b0>