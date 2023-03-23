class Todo < ApplicationRecord
  belongs_to :user

  enum :status, [ :CREATED, :STARTED, :COMPLETED, :CANCELLED ]
  enum :priority, [ :LOW, :MEDIUM, :HIGH ]

  validates :title, presence: true, length: {minimum:5, maximum:25}
  validates :description, presence: true, length: {minimum: 20}
  # validates :status, numericality: {less_than_or_equal_to: 0, greater_than_or_equal_to: 3} #, numericality: {in: 0..3}
  # validates :priority, numericality: {in: 0..2}
end
