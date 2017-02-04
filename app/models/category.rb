class Category < ApplicationRecord
  has_many :listener_deadline_values, -> { where(form_of_participation: 'Listener') }, 
    class_name: DeadlineValue, foreign_key: :category_id, dependent: :destroy, index_errors: true
  has_many :presenter_deadline_values, -> { where(form_of_participation: 'Presenter') },
    class_name: DeadlineValue, foreign_key: :category_id, dependent: :destroy

  validates :name, presence: true

  def listener_deadlines
    listener_deadline_values.map do |dv|
      Deadline.new(
        deadline: dv.deadline || nil,
        _destroy: dv._destroy || false
      )
    end
  end

  def presenter_deadlines
    presenter_deadline_values.map do |dv|
      Deadline.new(
        deadline: dv.deadline || nil,
        _destroy: dv._destroy || false
      )
    end
  end

  accepts_nested_attributes_for :listener_deadline_values, allow_destroy: true
  accepts_nested_attributes_for :presenter_deadline_values, allow_destroy: true
end
