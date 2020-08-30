require 'bundler'
Bundler.require

require 'sqlite3'
require_relative '../lib/student' #path up a level, down to liv, to load the student file

DB = {:conn => SQLite3::Database.new("db/students.db")}
#DB = connection )
 


# Remember, you can access your database connection anywhere in this class
#  with DB[:conn] 