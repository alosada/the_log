require 'sqlite3'
DATABASE = 'captains_log.db'
$db = SQLite3::Database.open("#{DATABASE}")
# require_relative "database_setup.rb"

# db_name = 'captains_log.db'
# db_connection = SQLite3::Database.new( "#{db_name}" )
$db = SQLite3::Database.open("captains_log.db")

class Logs

  def self.create(args)
    $db.execute(<<-SQL
      INSERT INTO Logs (user_id, name, description, priority)
      VALUES ('#{args[:user_id]}', '#{args[:name]}', '#{args[:description]}', '#{args[:priority]}');
    SQL
    )
  end

  def self.view_all(email)
    $db.execute(<<-SQL
      SELECT * FROM Logs WHERE Logs.email IS ('#{email}');
    SQL
    )
  end

  def self.find_log(id)
    $db.execute(<<-SQL
      SELECT * FROM Logs WHERE Logs.id IS ('#{id}');
    SQL
    )
  end

end

class Users
  def self.create(args)
   $db.execute(<<-SQL
      INSERT INTO Users (name, email, password)
      VALUES ('#{args[:name]}', '#{args[:email]}', '#{args[:password]}');
    SQL
    )
  end

  def self.authenticate_user(args)
    db_password = $db.execute(<<-SQL
      SELECT password
      FROM Users
      WHERE email IS ('#{args[:email]}');
      SQL
    )
    db_password.join("") == args[:password]
  end

  def self.all
    $db.execute(<<-SQL
      SELECT * FROM Users;
    SQL
    )
  end
end

class Events

end