class NestedForm < ActiveType::Object
  nests_many :categories, allow_destroy: true, index_errors: true
  nests_many :listener_deadlines, allow_destroy: true, scope: proc { Deadline }
  nests_many :presenter_deadlines, allow_destroy: true, scope: proc { Deadline }

  def listener_deadlines
    @listener_deadlines ||= categories.sample.try(:listener_deadlines)
  end

  def listener_deadlines_attributes=(attributes)
    @listener_deadlines = attributes.map { |_k, v| Deadline.new(v) }
    @listener_deadlines.each(&:validate)
    @listener_deadlines
  end

  def presenter_deadlines
    @presenter_deadlines ||= categories.sample.try(:presenter_deadlines)
  end

  def presenter_deadlines_attributes=(attributes)
    @presenter_deadlines = attributes.map { |_k, v| Deadline.new(v) }
    @presenter_deadlines.each(&:validate)
    @presenter_deadlines
  end
end
