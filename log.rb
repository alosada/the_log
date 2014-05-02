require '/Users/apprentice/Desktop/zack_ale_log_MVP/the_log/log_model.rb'
require '/Users/apprentice/Desktop/zack_ale_log_MVP/the_log/log_view.rb'

# module Factories
#   def create_view
#     View.new
#   end

#   def create_model
#     Users.new
#     #Model.new
#   end

# end



class Controller

  def initialize(model,view)
    @model = model
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




  private

  def quit
   @quit = quit
  end

  def quit?
    @quit
  end

  def create_user
    input = @view.create_account
    @model.authenticate_user(input)
  end

  def authenticate
    input = @view.login
    quit if input == 'quit'
    @login_status = @model.authenticate_user(input)
    @current_user = input[:email] if @login
    unless @login_status || !quit?
      @view.login_fail
      authenticate
    end
  end

end
db_name = 'captains_log.db'
db_connection = SQLite3::Database.new( "#{db_name}" )

log_model = Users.new(db_name)
log_view = View.new
log_cont = Controller.new(log_model, log_view)
log_cont.start
