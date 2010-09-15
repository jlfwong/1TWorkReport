require File.dirname(__FILE__) + '/../test_helper'

class AccessTest < ActionDispatch::IntegrationTest
  def test_admin
    get '/admin/', nil, auth_header
    assert_response :success

    get '/admin/posts', nil, auth_header
    assert_response :success
  end

  def test_anon
    get '/admin/'
    assert_response :unauthorized

    get '/admin/posts'
    assert_response :unauthorized
  end
  
  def test_failed_login
    get '/admin/', nil, auth_header('fake','fake')
    assert_response :unauthorized

    get '/admin/posts', nil, auth_header('fake','fake')
    assert_response :unauthorized
  end
end
