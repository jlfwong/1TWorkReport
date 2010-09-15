require File.dirname(__FILE__) + '/../test_helper'
class AdminControllerTest < ActionController::TestCase
  setup :login

  def test_get_index
    get :index 
    assert_response :success
  end
end

