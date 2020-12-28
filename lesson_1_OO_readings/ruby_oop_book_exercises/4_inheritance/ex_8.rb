class Person
  def public_hi
    hi
  end

  private

  def hi
    puts 'hi'
  end
end

bob = Person.new
bob.public_hi