class Course < ActiveRecord::Base
  belongs_to :user
  has_many :announcement
  validates :title, presence: true, length: {maximum: 100}
  validates :description, presence: true, length: {maximum: 1000}
  validates :start_date, presence: true 
  validates :end_date, presence: true 
  validates :user, presence:true
  validates :status, presence:true, inclusion: {in: %w(Inactive Active), message: "%{value} is not a valid status"}
  validate :validate_start_before_end

  def validate_start_before_end 
    if (start_date != nil && end_date != nil)
    	if self.start_date> self.end_date
    		errors.add(:start_date,"Start date should be before end date")
    	end
    end
  end
end
