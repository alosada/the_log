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

p authenticate_user({email: 'ale@mail.com', password: 'ale'})