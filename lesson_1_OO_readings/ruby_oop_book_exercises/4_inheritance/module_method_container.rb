module Mammal
  def self.some_out_of_place_method(num)
    num ** 2
  end
end

value = Mammal.some_out_of_place_method(4)
p value # => 16

value = Mammal::some_out_of_place_method(4)
p value # => 16