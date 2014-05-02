require_relative 'log_model'
require_relative 'log_view'

module Factories
  def create_view
    View.new
  end

  def create_model
    Model.new
  end
end



class Controller
  def initialize(model,view)
    @model = model
    @view = view
    @quit = false
    @current_user = nil
    @login = false

  end

self.view.display(self.model.welcome)
self.view.display(self.model.menu)

  def start
    #until quit?
    @input = self.view.welcome
    if @input == 'login'
      authenticate
    elsif @input == 'create'
      create_user
    elsif @input == 'quit'
      quit
    else
      self.view.invalid_input
      start
    end
  end

unless quit?
  @output = self.model.get_logs
  self.view.display_logs(@output)
end



  private

  def quit
   @quit = quit
  end

  def quit?
    @quit
  end

  def create_user

  end

  def authenticate
    input = self.view.login
    quit if input =='quit'
    @login = self.model.authenticate_user(input)
    @current_user = input[:email] if @login
    unless @login || !@quit
      self.view.login_fail
      authenticate
    end
  end



end



log_cont = Controller.new(create_model, create_view)
log_cont.start
log_cont.input = gets.chomp