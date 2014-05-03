require 'sqlite3'
DATABASE = 'captains_log.db'
$db = SQLite3::Database.open("#{DATABASE}")

class Logs

  def create(args)
    $db.execute(<<-SQL
      INSERT INTO Logs (user_id, name, description, priority)
      VALUES ('#{args[:user_id]}', '#{args[:name]}', '#{args[:description]}', '#{args[:priority]}');
    SQL
    )
  end

  def view_all(email)
    $db.execute(<<-SQL
      select * from Logs
      JOIN Users
      ON (Logs.user_id = Users.id)
      WHERE Users.email IS ('#{email}');
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

  def all
    $db.execute(<<-SQL
      SELECT * FROM Users;
    SQL
    )
  end
end

class Events

end