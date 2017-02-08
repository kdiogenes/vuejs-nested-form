class NestedFormController < ApplicationController
  helper_method :build_nested_form

  def bad
    build_nested_form
  end

  def good
    build_nested_form
  end

  private

  def build_nested_form(ignore_params = false)
    @nested_form = NestedForm.new
    @nested_form.attributes = nested_form_params unless ignore_params
    @nested_form.categories = [Category.new] if @nested_form.categories.nil?
    @nested_form.categories.each do |category|
      category.listener_deadline_values.build if category.listener_deadline_values.empty?
      # category.presenter_deadline_values.build if category.presenter_deadline_values.empty?
    end
    @nested_form.validate if request.method == 'POST'
    @nested_form
  end

  def nested_form_params
    nested_form = params[:nested_form]
    if nested_form
      nested_form.permit(
        categories_attributes: [
          :id, :name, :_destroy,
          listener_deadline_values_attributes: [:id, :_destroy, :value, :deadline],
          presenter_deadline_values_attributes: [:id, :_destroy, :value, :deadline]
        ],
        listener_deadlines_attributes: [:_destroy, :deadline, :value],
        presenter_deadlines_attributes: [:_destroy, :deadline, :value]
      )
    else
      {}
    end
  end
end
