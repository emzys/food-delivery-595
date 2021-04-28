require_relative '../views/orders_view'
require_relative '../views/employees_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
    @orders_view = OrdersView.new
  end

  def list_undelivered_orders
    # ask the repository for undelivered orders
    orders = @order_repository.undelivered_orders
    # give the orders to the view to display
    @orders_view.display(orders)
  end

  def add
    # get the meals from the repository
    # diplay the meals for the manager
    # have the view ask the user for the index
    # get the one instance from the array with the index
    meals = @meal_repository.all
    @meals_view.display(meals)
    meal_index = @meals_view.ask_for('number of the meal').to_i - 1
    meal = meals[meal_index]

    # get the customers from the repository
    # diplay the customers for the manager
    # have the view ask the user for the index
    # get the one instance from the array with the index
    customers = @customer_repository.all
    @customers_view.display(customers)
    customer_index = @customers_view.ask_for('number of the customer').to_i - 1
    customer = customers[customer_index]

    # get the riders from the repository
    # diplay the riders for the manager
    # have the view ask the user for the index
    # get the one instance from the array with the index
    employees = @employee_repository.all_riders
    @employees_view.display(employees)
    employee_index = @employees_view.ask_for('number of the employee').to_i - 1
    employee = employees[employee_index]

    # create an order instance with the meal, customer, and employee
    order = Order.new(meal: meal, customer: customer, employee: employee)
    # save the instance in our repository
    @order_repository.create(order)
  end

  def list_my_orders(employee)
    # ask the repository for MY UNDELIVERED orders
    orders = @order_repository.my_undelivered_orders(employee)
    # give those orders to the view to display
    @orders_view.display(orders)
  end

  def mark_as_delivered(employee)
    orders = @order_repository.my_undelivered_orders(employee)
    @orders_view.display(orders)
    index = @orders_view.ask_for('number of the order').to_i - 1
    order = orders[index]
    @order_repository.mark_as_delivered(order)
  end


end
