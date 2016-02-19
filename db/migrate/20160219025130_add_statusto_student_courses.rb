class AddStatustoStudentCourses < ActiveRecord::Migration
  def change
  	add_column :student_courses, :status, :string
  end
end
