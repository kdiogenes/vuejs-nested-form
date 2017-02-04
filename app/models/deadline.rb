class Deadline < ActiveType::Object
  attribute :deadline, :date
  attribute :_destroy, :boolean
  validates :deadline, presence: true
end
