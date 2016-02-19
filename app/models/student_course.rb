class StudentCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :status, inclusion: {in: %w(pending enrolled completed), message: "%{value} is not a valid enrollment status"}
  validates :grade, inclusion: {in: %w(A+ A A- B+ B B- C+ C C- F), message: "%{value} is not a valid grade"}
  
end
