class NestedForm < ActiveType::Object
  nests_many :categories, allow_destroy: true
  nests_many :listener_deadlines, allow_destroy: true, scope: proc { Deadline }
  nests_many :presenter_deadlines, allow_destroy: true, scope: proc { Deadline }

  def listener_deadlines_attributes=(attributes)
    @listener_deadlines = attributes.map { |_k, v| Deadline.new(v) }
  end

  def presenter_deadlines_attributes=(attributes)
    @presenter_deadlines = attributes.map { |_k, v| Deadline.new(v) }
  end
end
