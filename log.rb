require_relative 'log_model.rb'
require_relative 'log_view.rb'


class Controller

  def initialize(model,view)
    @users = model[0]
    @logs = model[1]
    @view = view
    @quit = false
    @current_user = nil
    @login = false
    @command = nil
  end


  def start
    until logged_in? || quit? do
      command = @view.welcome
      if command == 'login'
        authenticate
        view_logs(@current_user)
      elsif command == 'create'
        create_user
      elsif command == 'quit'
        quit
      else
        @view.invalid_input
      end
    end
  end

  private

  def quit
   @quit = quit
  end

  def quit?
    @quit
  end

  def quit
   @quit = true
  end

  def quit?
    @quit
  end

  def logged_in?
    @login
  end

  def authenticate
    until  logged_in? || quit? do
      input = @view.login
      quit if input == 'quit'
      @login = @users.authenticate_user(input)
      @current_user = @users.get_id(input[:email])[0][0] if logged_in?
      @view.login_fail unless logged_in?
    end
  end

  def create_user
    input = @view.create_user
    @users.create(input)
  end

  def view_logs(current_user)
    output = @logs.read_all(current_user)
    input = @view.display_logs(output)
  end

end

log_cont=Controller.new([Users.new, Logs.new], View.new)
log_cont.start