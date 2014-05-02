require 'sqlite3'
# require_relative "database_setup.rb"

# db_name = 'captains_log.db'
# db_connection = SQLite3::Database.new( "#{db_name}" )

class Logs
  attr_reader :db
  def initialize(db_name = 'captains_log.db')
    # db_name = 'captains_log.db'
    @db = SQLite3::Database.new("#{db_name}") #db_connection
  end

  def create(args)
    @db.execute(<<-SQL
      INSERT INTO Logs (user_id, name, description, priority)
      VALUES ('#{args[:user_id]}', '#{args[:name]}', '#{args[:description]}', '#{args[:priority]}');
    SQL
    )
  end

  def all(id)
    @db.execute(<<-SQL
      SELECT * FROM Logs WHERE Logs.user_id IS ('#{id}');
    SQL
    )
  end

  def find(id)
    @db.execute(<<-SQL
      SELECT * FROM Logs WHERE Logs.id IS ('#{id}')
    SQL
    )
  end

end

class Users
  def initialize (db_name = 'captains_log.db')
    @db = SQLite3::Database.new('captains_log.db') #database_connection(db_name)
  end

  def create(args)
    # @db = SQLite3::Database.new('captains_log.db')
    @db.execute(<<-SQL
      INSERT INTO Users (name, email, password)
      VALUES ('#{args[:name]}', '#{args[:email]}', '#{args[:password]}');
    SQL
    )
  end

  def authenticate_user(args)
    # @db = SQLite3::Database.new('captains_log.db')
    db_password = @db.execute(<<-SQL
      SELECT password
      FROM Users
      WHERE email IS ('#{args[:email]}');
      SQL
    )
    db_password.join("") == args[:password]
  end

  def all
    @db.execute(<<-SQL
      SELECT * FROM Users;
    SQL
    )
  end
end

class Events

end

users = Users.new
# Logs.create(user_id: 123, name:'crazy adventures', description: 'OMGOGOMGOMGOMGOMGOMGOMGOMGOMG', priority: 'mega high')
# puts Logs.all(123)
# users.create(name: 'Bob', email: 'lkjasdflkjsadflkj', password: 'test123')

# puts users.authenticate_user(email: 'testy@mctesterson.com', password: 'test123')

# users = Users.new
# users.create(name: "Bob", email: "testy@mctesterson.com", password: "test123")

# test_user = Users.new(name: "Bob", email: "testy@mctesterson.com", password: "test123")

# puts users.all

logs = Logs.new

puts logs.all(1)

logs.create(user_id: 123, name:'crazy adventures', description: 'OMGOGOMGOMGOMGOMGOMGOMGOMGOMG', priority: 'mega high')

puts logs.all(123)

puts logs.find(2)

puts logs.find(234234234)