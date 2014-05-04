require_relative 'log_model.rb'
require_relative 'log_view.rb'


class Controller

  def initialize(view, users, logs, events)
    @events = events
    @users = users
    @logs = logs
    @view = view
    @quit = false
    @current_user = nil
    @active_log = nil
    @login = false
    @back = false
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

  def quit?
    @quit
  end

  def quit
   @quit = true
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
    until quit? do
      output = @logs.read_all(current_user)
      input = @view.display_logs(output)
      if input.to_i.is_a?(Integer) && input.to_i != 0
        @active_log = input.to_i
        output = @logs.find_log(@active_log)
        @view.log_details(output)
        view_events(@active_log)
      elsif input == 'create_log'
        input = @view.create_log
        @logs.create_log(input, @current_user)
      elsif input == 'quit'
        quit
      else
        @view.invalid_input
      end
    end  
  end

  def view_events(active_log)
    until back?
    output = @events.read_all(active_log)
    input = @view.display_events(output)  
      if input.to_i.is_a?(Integer) && input.to_i != 0
        output = @events.find_event(input)
        @view.event_details(output[0])
      elsif input == 'create_event'
        input = @view.create_event
        @events.create(input, @active_log)
      elsif input == 'back'
        back
      else
        @view.invalid_input
      end
    end   
  end

  def back?
    @back
  end

  def back
    @back=true
  end

end

log_cont=Controller.new(View.new, Users.new, Logs.new, Events.new)
log_cont.start