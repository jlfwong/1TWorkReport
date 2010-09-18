require File.dirname(__FILE__) + '/../test_helper'

class BlogPostsControllerTest < ActionController::TestCase
  def test_get_index
    get :index
    assert_response :success
    assert assigns(:blog_posts).present?
    assert assigns(:blog_posts).include? blog_posts(:published)
    assert !(assigns(:blog_posts).include? blog_posts(:unpublished))
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
    blog_post = blog_posts(:published)
    get :show, :id => blog_post
    assert_response :success
    assert_body_contains blog_post.title
    assert_body_contains blog_post.content
    assert_body_contains comments(:default).content
    assert_body_contains comments(:reply).content
  end

  def test_get_show_unpublished
    get :show, :id => blog_posts(:unpublished)
    assert_response :not_found
  end
end
