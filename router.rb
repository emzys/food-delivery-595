class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    puts "Welcome to the Le Wagon Restaurant!"
    puts "           --           "
    while @running
      @employee = @sessions_controller.sign_in
      while @employee
        if @employee.manager?
          display_manager_tasks
          action = gets.chomp.to_i
          print `clear`
          route_manager_action(action)
        else
          display_rider_tasks
          action = gets.chomp.to_i
          print `clear`
          route_rider_action(action)
        end
      end
    end
  end

  private

  def route_manager_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.list_undelivered_orders
    when 6 then @orders_controller.add
    when 9 then sign_out
    when 0 then stop
    else
      puts "Please press 1, 2, 3, 4 or 9"
    end
  end

  def route_rider_action(action)
    case action
    when 1 then @orders_controller.list_my_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    when 9 then sign_out
    when 0 then stop
    else
      puts "Please press 1, 2, 3, 4 or 9"
    end
  end

  def sign_out
    @employee = nil
  end

  def stop
    @running = false
    @employee = nil
  end

  def display_manager_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all meals"
    puts "2 - Create a new meal"
    puts "3 - List all customers"
    puts "4 - Create a new customer"
    puts "5 - List all undelivered orders"
    puts "6 - Add an order"
    puts "9 - Sign out"
    puts "0 - Stop and exit the program"
  end

  def display_rider_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List my undelivered order"
    puts "2 - Mark order as delivered"
    puts "9 - Sign out"
    puts "0 - Stop and exit the program"
  end
end
