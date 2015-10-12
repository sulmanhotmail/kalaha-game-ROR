require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get main" do
    get :main
    assert_response :success
  end

  test "should get temp" do
    get :temp
    assert_response :success
  end

end
