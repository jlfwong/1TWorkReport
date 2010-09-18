require File.dirname(__FILE__) + '/../test_helper'

class BlogPostsControllerTest < ActionController::TestCase
  def test_get_index
    2.times {Factory(:blog_post)}
    unpublished_post  = Factory(:unpublished_blog_post)
    published_post    = Factory(:published_blog_post)
    get :index
    assert_response :success
    assert assigns(:blog_posts).present?
    assert assigns(:blog_posts).include? published_post
    assert !(assigns(:blog_posts).include? unpublished_post)
    BlogPost.all.each do |blog_post|
      assert_body_contains blog_post.title
      assert_body_contains blog_post.content
    end
  end
  
  def test_get_empty_index
    get :index
    assert assigns(:blog_posts).empty?
    assert_response :success
  end

  def test_get_show
    blog_post = Factory(:published_blog_post)
    comment = Factory(:comment, :blog_post => blog_post, :parent => blog_post)
    reply = Factory(:comment, :blog_post => blog_post, :parent => comment)
    get :show, :id => blog_post
    assert_response :success
    assert_body_contains blog_post.title
    assert_body_contains blog_post.content
    assert_body_contains comment.content
    assert_body_contains reply.content
  end

  def test_get_new_unpublished
    get :show, :id => Factory(:unpublished_blog_post)
    assert_response :not_found
  end
end

