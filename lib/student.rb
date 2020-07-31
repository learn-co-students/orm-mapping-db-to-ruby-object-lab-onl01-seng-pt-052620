class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    student_new = self.new
    student_new.id = row[0]
    student_new.name = row[1]
    student_new.grade = row[2]
    student_new
  end

  def self.all
    sql = <<-SQL
    SELECT * FROM students
    SQL

    DB[:conn].execute(sql).collect do |row|
      self.new_from_db(row)
    end
  end

  # Searching SQL and returning Ruby objects

  def self.find_by_name(name)
    sql = <<-SQL
      SELECT * FROM students WHERE name = ? LIMIT 1
    SQL

    DB[:conn].execute(sql,name).collect do |row|
      self.new_from_db(row)
    end.first
  end

  def self.all_students_in_grade_9
    sql = <<-SQL
      SELECT * FROM students WHERE grade = 9
    SQL

    DB[:conn].execute(sql).collect do |row|
      self.new_from_db(row)
    end
  end

  def self.students_below_12th_grade
    sql = <<-SQL
    SELECT * FROM students WHERE grade < 12
    SQL

    DB[:conn].execute(sql).collect do |row|
    self.new_from_db(row)
    end

  end

  def self.first_X_students_in_grade_10(student_count)
    sql = <<-SQL
    SELECT * FROM students WHERE grade = 10
    SQL

    DB[:conn].execute(sql).collect do |row|
      self.new_from_db(row)
      end.take(student_count)
  
  end

  def self.first_student_in_grade_10
    sql = <<-SQL
    SELECT * FROM students WHERE grade = 10
    SQL

    DB[:conn].execute(sql).collect do |row|
      self.new_from_db(row)
      end.first
  end

  def self.all_students_in_grade_X(grade)
    sql = <<-SQL
      SELECT * FROM students WHERE grade = ?
    SQL

    DB[:conn].execute(sql,grade).collect do |row|
      self.new_from_db(row)
    end

  end



  # Starts creating SQL from Ruby
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
