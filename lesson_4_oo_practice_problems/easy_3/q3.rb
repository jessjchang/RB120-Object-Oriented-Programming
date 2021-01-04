class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

grumpy = AngryCat.new(5, 'Grumpy')
crabby = AngryCat.new(2, 'Crabby')

grumpy.age # => 5
crabby.age # => 2

grumpy.name # => Grumpy
crabby.name # => Crabby

