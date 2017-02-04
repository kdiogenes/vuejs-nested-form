require 'test_helper'

class NestedFormControllerTest < ActionDispatch::IntegrationTest
  test "should get bad" do
    get nested_form_bad_url
    assert_response :success
  end

  test "should get good" do
    get nested_form_good_url
    assert_response :success
  end

end
