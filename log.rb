require '/Users/apprentice/Desktop/zack_ale_log_MVP/the_log/log_model.rb'
require '/Users/apprentice/Desktop/zack_ale_log_MVP/the_log/log_view.rb'


class Controller
  attr_reader :login
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
    unless login
      command = @view.welcome
      if command == 'login'
        authenticate
      elsif command == 'create'
        create_user
      elsif command == 'quit'
        quit
      else
        @view.invalid_input
        start
      end
    end
  end

  def show_logs
    output = @logs.read_all(@current_user)
    input = @view.display_logs(output)
  end

  private

  def quit
   @quit = quit
  end

  def quit?
    @quit
  end

  def create_user
    input = @view.create_user
    @users.create(input)
    authenticate
  end

  def authenticate
    input = @view.login
    quit if input == 'quit'
    @login = @users.authenticate_user(input)
    @current_user = input[:user_id] if @login
    unless @login || quit?
      @view.login_fail
      authenticate
    end
  end

  def create_log
    input = @view.create_logs
    input[:user_id] = @current_user
    @logs.create_log(input)
  end

end



