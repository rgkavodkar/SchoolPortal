class Announcement < ActiveRecord::Base
  belongs_to :course

  validates :title, presence: true, length: {maximum: 100}
  validates :content, presence: true, length: {maximum: 1000}
end
