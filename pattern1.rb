# If some logic need to be executed based on a single branch based on a condition
# we could use blocks to avoid using an if branching.

class Order
  def confirm
    # confirm order
  end

  def cancel
    # cancel order
  end
end

# Using if condition to check if the payment is success and confirm order
class OrderService

  def perform
    if payment_success?(order)
      @order.confirm
    end
  end
end

# Using a block to replace the if statement
# here you provide the logic as a block of code that need to be executed
# once the order is success
class OrderService

  def payment_success(order, &block)
    status = check_payment_status_for(order)
    block.call(order) if status == "success"
  end

  def perform
    payment_success?(order) do |order|
      order.confirm
    end
  end
end





