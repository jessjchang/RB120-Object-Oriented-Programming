class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer # => would raise a NoMethodError, because we are calling `manufacturer` on an instance of the `Television` class, but there is no `manufacturer` instance method, we only have a `manufacturer` class method to be called on the `Television` class itself
tv.model # => would call the `model` instance method

Television.manufacturer # => would call the `manufacturer` class method
Television.model # => would raise a NoMethodError, because we are calling `model` on the `Television` class itself, but there is no `model` class method, we only have a `model` instance method to be called on an instance of the `Television` class