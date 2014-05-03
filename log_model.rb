require 'sqlite3'
DATABASE = 'captains_log.db'
$db = SQLite3::Database.open("#{DATABASE}")
# require_relative "database_setup.rb"

# db_name = 'captains_log.db'
# db_connection = SQLite3::Database.new( "#{db_name}" )

class Logs
  #attr_reader :db
  def initialize#(db_name = 'captains_log.db')
    # db_name = 'captains_log.db'
     #db_connection
  end

  def create(args)
    $db.execute(<<-SQL
      INSERT INTO Logs (user_id, name, description, priority)
      VALUES ('#{args[:user_id]}', '#{args[:name]}', '#{args[:description]}', '#{args[:priority]}');
    SQL
    )
  end

  def all(id)
    $db.execute(<<-SQL
      SELECT * FROM Logs WHERE Logs.user_id IS ('#{id}');
    SQL
    )
  end

  def find(id)
    $db.execute(<<-SQL
      SELECT * FROM Logs WHERE Logs.id IS ('#{id}');
    SQL
    )
  end

end

class Users
  def initialize #(db_name = 'captains_log.db')
    #$db = SQLite3::Database.new('captains_log.db') #database_connection(db_name)
  end

  def create(args)
    # $db = SQLite3::Database.new('captains_log.db')
    $db.execute(<<-SQL
      INSERT INTO Users (name, email, password)
      VALUES ('#{args[:name]}', '#{args[:email]}', '#{args[:password]}');
    SQL
    )
  end

  def authenticate_user(args)
    # $db = SQLite3::Database.new('captains_log.db')
    db_password = $db.execute(<<-SQL
      SELECT password
      FROM Users
      WHERE email IS ('#{args[:email]}');
      SQL
    )
    db_password.join("") == args[:password]
  end

  def all
    $db.execute(<<-SQL
      SELECT * FROM Users;
    SQL
    )
  end
end

class Events

end

#users=Users.new
#p users.create(name: 'ale', email: 'ale@ale.com', pass: 'ale')
#p $db.execute('select * from users')
