require 'csv'
require_relative '../models/order'

class OrderRepository

  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @csv_file_path = csv_file_path
    @orders = []
    @next_id = 1 # we use this to give to the next instance that needs an id
    load_csv if File.exist?(@csv_file_path) # this breaking when there's no csv file
  end

  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def undelivered_orders
    @orders.reject do |order|
      order.delivered?
    end
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select do |order|
      order.employee == employee
    end
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # hash[new_key] = value
      # converting string id to integer
      meal_id = row[:meal_id].to_i
      # place the instance into the row hash
      row[:meal] = @meal_repository.find(meal_id) # INSTANCE of a meal

      customer_id = row[:customer_id].to_i
      row[:customer] = @customer_repository.find(customer_id) # INSTANCE of a customer

      employee_id = row[:employee_id].to_i
      row[:employee] = @employee_repository.find(employee_id) # INSTANCE of a employee

      row[:id] = row[:id].to_i # turn id into integer
      row[:delivered] = row[:delivered] == 'true' # turn id into boolean

      @orders << Order.new(row)
    end
    @next_id = @orders.any? ? @orders.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'meal_id', 'customer_id', 'employee_id', 'delivered']
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered?]
      end
    end
  end
end
