class Book
  attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.) # => The author of "Snow Crash" is Neil Stephenson.
puts %(book = #{book}.) # => book = "Snow Crash", by Neil Stephenson.

#Further Exploration
# attr_reader defines a getter method, attr_writer defines a setter method, and attr_accessor defines both. We could 
# have used attr_accessor instead of attr_reader, but it was a bit unnecessary in this particular case since we
# only needed a getter method to reference the string object referenced by the instance variables `@title` and 
# `@author`.


# Instead of attr_reader, suppose you had added the following methods to this class:
def title
  @title
end

def author
  @author
end

# This wouldn't have changed the behavior of the class, since attr_reader is essentially just Ruby shorthand for
# these two getter methods. This code would have been useful if we wanted to go ahead and format the strings referenced
# by `@title` or `@author` in any way when we return them with these getter methods. 