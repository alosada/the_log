
require 'io/console'

class View

  def clear_screen
    puts "\e[H\e[2J"
  end

  def welcome  #welcome/login screen
    puts "Welcome to THE LOG"
    puts "type LOGIN to login to an existing account"
    puts "type CREATE to make a new account"
    puts "type QUIT at any time to exit this app"
    choice = gets.chomp.downcase
  end

  def invalid_input
    puts "input invalid, please try again"
  end

  def login
    user_pass = {}
    puts "enter your username"
    user_pass[:user_name] = gets.chomp
    puts "Enter your password: "
    user_pass[:password] = STDIN.noecho(&:gets).chomp
    user_pass
  end

  def login_fail
    puts "incorrect username/password"
  end

  def create_account
    user_info = {}
    puts "enter your desired username."
    user_info[:user_name] = gets.chomp
    puts "enter your e-mail address."
    user_info[:email] = gets.chomp
    puts "enter your password."
    user_info[:password] = STDIN.noecho(&:gets).chomp
    user_info
  end

  ##### LOG SPECIFIC METHODS

  def display_logs(user_logs) #user_logs is an array of logs
    user_logs.each do |log|
      entry = "| #{log[:name].ljust(25)} |"
      puts  "-" * (entry.length)
      puts entry
    end
    puts "to view a log type in the LOG_ID"
    puts "type CREATE_LOG to create a new log"
    puts "type LOGOUT to logout."
    choice = gets.chomp.type
  end

  def log_details(log)
    log.each_key do |entry|
      puts "#{entry}: #{log[entry]}"
    end
  end

  def create_logs #returns a hash of things a user can put in.
    log_info = {}
    puts "Enter the name of the log"
    log_info[:name] = gets.chomp
    puts "Enter the description of the log"
    log_info[:description] = gets.chomp
    puts "Enter the priority of the log"
    log_info[:priority] = gets.chomp
    puts "Log created!"
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

  def create_events
    events_info = {}
    puts "Enter the name of the event"
    events_info[:name] = gets.chomp
    puts "Enter the description of the event"
    events_info[:description] = gets.chomp
    events_info
  end

  def display_events(log, events) #logs takes a log (hash), events is an array of event hashes
    puts log[:name]
    events.each do |event|
      entry = "| EVENT_ID = #{event[:id]}| #{event[:name].ljust(25)} |"
      puts  "-" * (entry.length)
      puts entry
    end
    puts "-" * (entry.length)
    puts "to view an EVENT type in the EVENT_ID"
    puts "type CREATE_LOG to create a new log"
    puts "type LOGOUT to logout at any time."
    choice = gets.chomp
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

  def event_details(event)
    event.each_key do |entry|
      puts "#{entry}: #{event[entry]}"
    end
  end

end