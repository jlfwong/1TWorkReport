require File.dirname(__FILE__) + '/../../test_helper'

class Admin::BlogPostsControllerTest < ActionController::TestCase
  setup :login

  def test_get_index
    2.times {Factory(:blog_post)}
    get :index
    assert_response :success
    assert assigns(:blog_posts).present?
    BlogPost.all.each do |blog_post|
      assert_body_contains blog_post.title
    end
    assert_template :index
  end

  def test_get_empty_index
    get :index
    assert_response :success
    assert assigns(:blog_posts).empty?
    assert_template :index
  end

  def test_get_new
    get :new
    assert_response :success
    assert assigns(:blog_post).present?
    assert_template :new
  end

  def test_create
    assert_difference 'BlogPost.count' do
      post :create, :blog_post => Factory.attributes_for(:blog_post)
      assert_equal 'Blog Post Created', flash[:notice]
      assert_response :redirect
      assert_redirected_to :action => :index
    end
  end

  def test_create_failure
    assert_no_difference 'BlogPost.count' do
      post :create, :blog_post => {}
      assert_response :success
      assert_template :new
    end
  end

  def test_get_edit
    blog_post = Factory(:blog_post)
    get :edit, :id => blog_post.id
    assert assigns(:blog_post).present?
    assert_response :success
    assert_body_contains blog_post.title
    assert_body_contains blog_post.content
  end

  def test_update
    blog_post = Factory(:blog_post)
    put :update, :id => blog_post, :blog_post => {
      :title => 'New Title'
    }
    assert_response :redirect
    assert_redirected_to :action => :edit

    blog_post.reload
    assert_equal 'New Title', blog_post.title
  end

  def test_update_failured
    blog_post = Factory(:blog_post)
    put :update, :id => blog_post, :blog_post => {
      :title => '.'
    }
    assert_response :success
    assert_template :edit
  end

  def test_destroy
    blog_post = Factory(:blog_post)
    assert_difference 'BlogPost.count', -1 do
      delete :destroy, :id => blog_post.id
    end
    assert_equal 'Blog Post Deleted', flash[:notice]
    assert_response :redirect
    assert_redirected_to :action => :index
  end
end

