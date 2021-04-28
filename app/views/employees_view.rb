require_relative 'base_view'

class EmployeesView < BaseView
  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1} - #{employee.username} - Role: #{employee.role}"
    end
  end
end
