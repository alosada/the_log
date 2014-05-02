
require 'io/console'

class View

  def welcome  #welcome/login screen
    puts "Welcome to THE LOG"
    puts "type LOGIN to login to an existing account or type CREATE to make a new account. "
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
    user_info[:password] STDIN.noecho(&:gets).chomp
    user_info
  end

  def display_logs(user_logs)
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

  def create_logs
    log_info = {}
    name
  end

  def display_events(log, events)
    puts log[:name]
    events.each do |event|
      puts  "-" * (entry.length)
      entry = "|#{event[:id]}| #{event[:name].ljust(25)} |"
      puts entry
    end
    puts puts  "-" * (entry.length)
    puts "to view an EVENT type in the EVENT_ID"
    puts "to create a new log type in \"create_log\""
    puts "type LOGOUT to logout at any time."
    choice = gets.chomp
  end



  # def add_event
  #   puts "Type in the event you want to add"
  #   gets.chomp
  # end

  # def add_success!
  #   puts "Entry added!"
  # end

  # def complete_task(list)
  #   puts "Enter number of the task you would like to complete."
  #   self.display_tasks(list)
  #   gets.chomp
  # end

  # def complete_success!
  #   puts "Task completed!"
  # end

  # def delete_task(list)
  #   puts "Enter the number of which task you would like to delete"
  #   self.display_tasks(list)
  #   gets.chomp
  # end

  # def delete_success!
  #   puts "Task deleted!"
  # end

  # def display_tasks (list)
  #   list.tasks.each_with_index do |task, index|
  #     number = index + 1
  #     puts "#{number}. " + "#{task}:" + " #{task.completed}"
  #   end
  # end

end