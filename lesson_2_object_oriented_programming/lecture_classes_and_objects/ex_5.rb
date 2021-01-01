class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    separate_name(name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(name)
    separate_name(name)
  end

  def same_name?(other_person)
    name == other_person.name
  end

  def to_s
    name
  end

  private

  def separate_name(name)
    names = name.split
    self.first_name = names.first
    self.last_name = names.size > 1 ? names.last : ''
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}" # => The person's name is: Robert Smith