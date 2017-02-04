class DeadlineValue < ApplicationRecord
  belongs_to :category, optional: true

  validates :value, :deadline, presence: true
end
