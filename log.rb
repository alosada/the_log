require '/Users/apprentice/Desktop/zack_ale_log_MVP/the_log/log_model.rb'
require '/Users/apprentice/Desktop/zack_ale_log_MVP/the_log/log_view.rb'


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

  def show_logs
    p 'inside show logs'
    output = @logs.all(@current_user)
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
    input = @view.create_account
    @users.create(input)
    authenticate
  end

  def authenticate
    input = @view.login
    quit if input == 'quit'
    @login = @users.authenticate_user(input)
    @current_user = input[:email] if @login
    #p @current_user
    p @login
    unless @login || quit?
      @view.login_fail
      authenticate
    end
  end

end
#db_name = 'captains_log.db'
#db_connection = SQLite3::Database.new( "#{db_name}" )

log_model = [Users.new, Logs.new]#(db_name)
log_view = View.new
log_cont = Controller.new(log_model, log_view)
#require 'debugger'; debugger;
log_cont.start
log_cont.show_logs
