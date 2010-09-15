require File.dirname(__FILE__) + '/../test_helper'

class BlogPostsControllerTest < ActionController::TestCase
  def test_get_index
    get :index
    assert_response :success
    assert assigns(:blog_posts).present?
    BlogPost.all.each do |blog_post|
      assert_body_contains blog_post.title
      assert_body_contains blog_post.content
    end
  end
  
  def test_get_empty_index
    BlogPost.destroy_all
    get :index
    assert assigns(:blog_posts).empty?
    assert_response :success
  end

  def test_get_show
    blog_post = blog_posts(:default)
    get :show, :id => blog_post
    assert_response :success
    assert_body_contains blog_post.title
    assert_body_contains blog_post.content
  end
end
