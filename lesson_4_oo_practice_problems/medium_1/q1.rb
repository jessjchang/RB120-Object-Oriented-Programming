class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

# We don't need to put an `@` before `balance` when referring to the `balance` instance variable in the body of the `postiive_balance?` method, because `attr_reader` on `line 2` created a `balance` getter method that will return the value of the `@balance` instance variable when called within the `positive_balance?` method.