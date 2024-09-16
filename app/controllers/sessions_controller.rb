require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def sign_in
    # we need the view to ask for the username
    username = @sessions_view.ask_for('username')
    # we need the view to ask for the password
    password = @sessions_view.ask_for('password')
    # we need ask the repository for an employee with the username
    employee = @employee_repository.find_by_username(username) # instance / nil
    if employee && employee.password == password
      # check password with the user input (if)
      #   "sign them in" / welcome message
      @sessions_view.welcome(employee) # nil
      return employee
    else
      #   "wrong password/username"
      @sessions_view.wrong_credentials # nil
      sign_in
    end
  end
end
