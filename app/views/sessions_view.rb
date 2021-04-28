require_relative 'base_view'

class SessionsView < BaseView
  def wrong_credentials
    puts "Sorry wrong username or password."
  end

  def welcome(employee)
    puts "Welcome #{employee.username}"
  end

end
