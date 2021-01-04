class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
oracle.predict_the_future # => return value will be a string with one of 3 values at random. Could be: 'You will eat a nice lunch', 'You will take a nap soon', or 'You will stay at work late'