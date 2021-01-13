class BankAccount
  attr_accessor :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    if amount > 0 && valid_transaction?(balance - amount)
      success = (self.balance -= amount)
    else
      success = false
    end

    if success
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  def valid_transaction?(new_balance)
    new_balance >= 0
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
p account.balance         # => 50

# FURTHER EXPLORATION

# What will the return value of a setter method be if you mutate its argument in the method body?

# The return value would be the value of the mutated argument.

class BankAccount
  attr_reader :client_name

  def initialize(client_name)
    @client_name = client_name
  end

  def client_name=(new_client_name)
    @client_name = new_client_name.upcase!
  end
end

account = BankAccount.new('jim')
mutated = (account.client_name = 'bob')
puts account.client_name # => BOB
puts mutated # => BOB