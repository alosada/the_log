require 'sqlite3'
# require_relative "database_setup.rb"

db_name = 'captains_log.db'
db_connection = SQLite3::Database.new( "#{db_name}" )

class Logs

end

class Users
  def initialize (db_connection)
    @db = db_connection #database_connection(db_name)
  end

  def create(args)
    @db.execute(<<-SQL
      INSERT INTO Users (name, email, password)
      VALUES ('#{args[:name]}', '#{args[:email]}', '#{args[:password]}');
    SQL
    )
  end

  def authenticate_user(args)
    db_password = @db.execute(<<-SQL
      SELECT password
      FROM Users
      WHERE email IS ('#{args[:email]}');
      SQL
    )
    db_password.join("") == args[:password]
  end



end

class Events

end

users = Users.new(db_connection)
# users.create(name: 'Bob', email: 'testy@mctesterson.com', password: 'test123')

# puts users.authenticate_user(email: 'testy@mctesterson.com', password: 'test123')

# users = Users.new
# users.create(name: "Bob", email: "testy@mctesterson.com", password: "test123")

# test_user = Users.new(name: "Bob", email: "testy@mctesterson.com", password: "test123")