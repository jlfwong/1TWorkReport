require File.dirname(__FILE__) + '/../test_helper'

class CommentsControllerTest < ActionController::TestCase
  def test_get_new_comment
    blog_post = Factory(:published_blog_post)
    get :new, :blog_post_id => blog_post.to_param
    assert assigns(:comment)
    assert_equal blog_post, assigns(:comment).parent
    assert_response :success
  end

  def test_get_new_reply
    parent_comment = Factory(:comment)
    get :new, :id => parent_comment, :blog_post_id => parent_comment.parent
    assert assigns(:comment)
    assert_equal parent_comment, assigns(:comment).parent
    assert_response :success
  end

  def test_create_comment
    blog_post = Factory(:published_blog_post)
    assert_difference 'Comment.count' do
      post :create, :comment => Factory.attributes_for(:comment,
        :blog_post    => blog_post,
        :parent       => blog_post
      )
    end
    assert assigns(:comment)
    assert_response :redirect
    assert_redirected_to blog_post_path(blog_post)
  end

  def test_create_comment_failure
    assert_no_difference 'Comment.count' do
      post :create, :blog_post_id => Factory(:published_blog_post).to_param
    end
    assert assigns(:comment)
    assert_response :success
    assert_template :new
  end

  def test_create_reply
    parent_comment = Factory(:comment)
    assert_difference 'Comment.count' do
      post :create, :comment => Factory.attributes_for(:comment_reply,
        :parent       => parent_comment,
        :blog_post    => parent_comment.blog_post
      )
      comment = assigns(:comment)
      assert assigns(:comment)
      assert_response :redirect
      assert_redirected_to blog_post_path(comment.blog_post)
    end
  end

  def test_create_reply_failure
    parent_comment = Factory(:comment)
    assert_no_difference 'Comment.count' do
      post :create, :id => parent_comment.to_param
      assert assigns(:comment)
      assert_response :success
      assert_template :new
    end
  end
end
