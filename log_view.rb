require 'io/console'

class View

  def clear_screen
    puts "\e[H\e[2J"
  end

  def welcome  #welcome/login screen
    clear_screen
    puts "******************************************"
    puts "*                                        *"
    puts "*          Welcome to The Log            *"
    puts "*                                        *"
    puts "******************************************"
    puts "\nType LOGIN to login to an existing account"
    puts "\nType CREATE to create a new user"
    puts "\nType QUIT at any time to exit this app"
    puts ''
    choice = gets.chomp.downcase
  end

  def invalid_input
    clear_screen
    puts "\n***Input invalid, please try again***"
    sleep(0.7)
  end

  def login
    clear_screen
    user_pass = {}
    puts "enter your email"
    user_pass[:email] = gets.chomp
    if user_pass[:email] == "quit"
      return "quit"
    end
    puts "Enter your password: "
    user_pass[:password] = STDIN.noecho(&:gets).chomp
    user_pass
  end

  def login_fail
    puts "incorrect username/password"
  end

  def create_user
    clear_screen
    user_info = {}
    puts "enter your name."
    user_info[:name] = gets.chomp
    puts "enter your e-mail address."
    user_info[:email] = gets.chomp
    puts "enter your password."
    user_info[:password] = STDIN.noecho(&:gets).chomp
    user_info
  end

  ##### LOG SPECIFIC METHODS

  def display_logs(user_logs) #user_logs is an array of logs
    clear_screen
    puts "|  ID  | Log name:                | Created:"
    if user_logs.empty?
      puts "You have no logs"
    end
    user_logs.each do |log|
      entry = "| #{log[0].to_s.ljust(4)} | #{log[2].ljust(24)} | #{log[6]}"
      puts  "-" * (entry.length)
      puts entry
    end
    puts "-" * 55
    puts "\nTo view a log type in the ID."
    puts "\nType CREATE_LOG to create a new log."
    puts "\nType QUIT to quit the program."
    gets.chomp
  end

  def log_details(log) #log is a hash
    clear_screen
    print "\n-Log id: "
    puts log[0][0]
    print "\n-Log name: "
    puts log[0][2]
    print "\n-Log description: "
    puts log[0][3]
  end

  def create_log #returns a hash of things a user can put in.
    log_info = {}
    puts "Enter the name of the log"
    log_info[:name] = gets.chomp
    puts "Enter the description of the log"
    log_info[:description] = gets.chomp
    puts "Enter the priority of the log"
    log_info[:priority] = gets.chomp
    puts "\n\nLog created!"
    sleep (0.7)
    log_info
  end

  def update_log(log) #log is a hash
    log.each_key do |entry|
      puts "Type in the new value of the entry #{entry}."
      log[entry] = gets.chomp
    end
    puts "log updated!"
  end

  def delete_log?
    puts "Are you sure you want to delete this log? (Y/N)"
    choice = gets.chomp
  end

  def delete_log
    puts "Log Deleted!"
  end

  def create_event
    events_info = {}
    puts "Enter the name of the event"
    events_info[:name] = gets.chomp
    puts "Enter the description of the event"
    events_info[:description] = gets.chomp
    events_info
  end

  def display_events(events) #logs takes a log (hash), events is an array of event hashes
    puts "\n|  ID  | Event name:              | Started:"
    events.each do |event|
      entry = "| #{event[0].to_s.ljust(4)}| #{event[2].ljust(24)} |#{event[7]}"
      puts  "-" * (event.length)
      puts entry
    end
    puts "-" * 55
    puts "\nTo view an event type in the EVENT_ID"
    puts "\nType CREATE_EVENT to create a new EVENT"
    puts "\nType BACK to go back to the logs view."
    gets.chomp
  end

  def update_event(event) #event is a hash
    event.each_entry do |entry|
      puts "Type in the new value of the entry #{entry}."
      event[entry] = gets.chomp
    end
    puts "event updated!"
  end

  def delete_event?
    puts "Are you sure you want to delete this event? (Y/N)"
    choice = gets.chomp
  end

  def delete_event
    puts "Event Deleted!"
  end

  def event_details(log) #log is a hash
    clear_screen
    print "\n-Event ID: "
    puts log[0][0]
    print "\n-Log ID: "
    puts log[0][1]
    print "\n-Event name: "
    puts log[0][2]
    print "\n-Event description: "
    puts log[0][3]
    print "\n-Created: "
    puts log[0][7]
    puts "\n Type BACK to go back to the previous menu."
    gets.chomp
  end

end