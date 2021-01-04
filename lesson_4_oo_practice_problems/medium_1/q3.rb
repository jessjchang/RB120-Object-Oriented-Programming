class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# Alyssa noticed that this will fail when `update_quantity` is called. Since quantity is an instance variable, it must be accessed with the `@quantity` notation when setting it. One way to fix this is to change `attr_reader` to `attr_accessor` and change `quantity` to `self.quantity`.
# Is there anything wrong with fixing it this way?

# There is nothing wrong syntactically with fixing it this way, but we may run into issues down the line in terms of protecting the quantity from being altered, as we would have a public setter method to change the quantity outside of the class and outside of the `update_quantity` instance method. 