class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student; end

# Further Exploration
class StudentPopulation
  attr_reader :id

  @@num_students = 0

  def initialize
    @@num_students += 1
    @id = @@num_students
  end
end

class Student < StudentPopulation
  def initialize(name, year)
    @name = name
    @year = year
    super()
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student; end

student1 = Graduate.new('student 1', 2020, 'yes')
p student1.id # => 1
student2 = Undergraduate.new('student 2', 2019)
p student2.id # => 2

