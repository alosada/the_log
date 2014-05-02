require 'sqlite3'

def database_connection(db_name)
  SQLite3::Database.new( "#{db_name}.db" )
end

database_connection("captains_log").execute("drop table if exists Users;")
database_connection("captains_log").execute("drop table if exists Logs;")
database_connection("captains_log").execute("drop table if exists Events;")

database_connection("captains_log").execute(<<-SQL
  create table Users
  (
    id INTEGER PRIMARY KEY,
    email varchar(255) unique,
    password varchar(255),
    name varchar(255),
    created_at datetime default CURRENT_TIMESTAMP,
    updated_at datetime default CURRENT_TIMESTAMP
    );
  SQL
  )


database_connection("captains_log").execute(<<-SQL
  create table Logs
  (
    id INTEGER PRIMARY KEY,
    user_id INTEGER REFERENCES Users(id),
    name varchar(255),
    description varchar(255),
    status varchar(255) not null default '',
    priority varchar(255),
    created_at datetime default CURRENT_TIMESTAMP,
    updated_at datetime default CURRENT_TIMESTAMP,
    closed_at datetime
    );
  SQL
  )


database_connection("captains_log").execute(<<-SQL
  create table Events
  (
    id INTEGER PRIMARY KEY,
    log_id INTEGER REFERENCES Logs(id),
    name varchar(255),
    description varchar(255),
    punctual varchar(255) DEFAULT NULL,
    started_at INTEGER,
    closed_at datetime,
    created_at datetime default CURRENT_TIMESTAMP,
    updated_at datetime default CURRENT_TIMESTAMP

    );
  SQL
  )

puts "done creating databases"

