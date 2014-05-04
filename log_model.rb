require 'sqlite3'
DATABASE = 'captains_log.db'
$db = SQLite3::Database.open("#{DATABASE}")

class Logs

  def create_log(args)
    $db.execute(<<-SQL
      INSERT INTO Logs (user_id, name, description, priority)
      VALUES ('#{args[:user_id]}', '#{args[:name]}', '#{args[:description]}', '#{args[:priority]}');
    SQL
    )
  end

  def read_all(user_id)
    $db.execute(<<-SQL
      select * from Logs
      JOIN Users
      ON (Logs.user_id = Users.id)
      WHERE Users.id IS ('#{user_id}');
    SQL
    )
  end

  def find_log(id)
    $db.execute(<<-SQL
      SELECT * FROM Logs WHERE Logs.id IS ('#{id}');
    SQL
    )
  end

end

class Users
  def create(args)
   $db.execute(<<-SQL
      INSERT INTO Users (name, email, password)
      VALUES ('#{args[:name]}', '#{args[:email]}', '#{args[:password]}');
    SQL
    )
  end

  def authenticate_user(args)
    db_password = $db.execute(<<-SQL
      SELECT password
      FROM Users
      WHERE email IS ('#{args[:email]}');
      SQL
    )
    db_password.join("") == args[:password]
  end

  def get_id(email)
    $db.execute(<<-SQL
      SELECT id
      FROM users
      WHERE email IS ('#{email}');
      SQL
      )
  end

  def all
    $db.execute(<<-SQL
      SELECT * FROM Users;
    SQL
    )
  end
end

class Events
  def create(args)
    $db.execute(<<-SQL
      INSERT INTO Events (log_id, name, description, punctual, null, null)
      VALUES ('#{args[:log_id]}', '#{args[:name]}', '#{args[:description]}', '#{args[:punctual]}');
    SQL
    )
  end
end