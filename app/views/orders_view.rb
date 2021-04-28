class OrdersView < BaseView
  def display(orders) # an array of instances
    orders.each_with_index do |order, index|
      puts "#{index + 1} - #{order.meal.name} - Customer: #{order.customer.name}"
      puts "    Address: #{order.customer.address} - Driver: #{order.employee.username}"
    end
  end
end
