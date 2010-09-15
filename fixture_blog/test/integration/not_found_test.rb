require File.dirname(__FILE__) + '/../test_helper'

class NotFoundTest < ActionDispatch::IntegrationTest
  def test_blog_post_not_found
    get '/posts/-1'
    assert_response :not_found
  end

  def test_admin_blog_post_not_found
    get '/admin/posts/-1/edit', nil, auth_header
    assert_response :not_found
  end
end
