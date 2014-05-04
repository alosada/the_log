require 'sqlite3'
DATABASE = 'captains_log.db'
$db = SQLite3::Database.open("#{DATABASE}")

def authenticate_user(args)
  db_password = $db.execute(<<-SQL
    SELECT password
    FROM Users
    WHERE email IS ('#{args[:email]}');
    SQL
  )
  db_password.join("") == args[:password]
end


  def create_log(args)
    $db.execute(<<-SQL
      INSERT INTO Logs (user_id, name, description, priority)
      VALUES ('#{args[:user_id]}', '#{args[:name]}', '#{args[:description]}', '#{args[:priority]}');
    SQL
    )
  end

    def find_log(id)
    $db.execute(<<-SQL
      SELECT * FROM Logs WHERE Logs.id IS ('#{id}');
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

#create_log({user_id: 2, name: "Ale log", description: "Ale log description", priority: "High"})

def met
read_all(2).each {|x| p x}
nil
end

met