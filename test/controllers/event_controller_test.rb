require 'test_helper'

class EventControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get find_contact" do
    get :find_contact
    assert_response :success
  end

end
