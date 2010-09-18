require File.dirname(__FILE__) + '/../test_helper'

class CommentsControllerTest < ActionController::TestCase
  def test_get_new_comment
    blog_post = blog_posts(:published)
    get :new, :blog_post_id => blog_post.to_param
    assert assigns(:comment)
    assert_equal blog_post, assigns(:comment).parent
    assert_response :success
  end

  def test_get_new_reply
    parent_comment = comments(:default)
    get :new, :id => parent_comment, :blog_post_id => parent_comment.parent
    assert assigns(:comment)
    assert_equal parent_comment, assigns(:comment).parent
    assert_response :success
  end

  def test_create_comment
    blog_post = blog_posts(:published)
    assert_difference 'Comment.count' do
      post :create, :comment => {
        :blog_post_id => blog_posts(:published).to_param,
        :parent_id    => blog_posts(:published).to_param,
        :parent_type  => 'BlogPost',
        :name         => 'Test Name',
        :content      => 'This is a comment'
      }
    end
    assert assigns(:comment)
    assert_response :redirect
    assert_redirected_to blog_post_path(blog_post)
  end

  def test_create_comment_failure
    assert_no_difference 'Comment.count' do
      post :create, :blog_post_id => blog_posts(:default).to_param
    end
    assert assigns(:comment)
    assert_response :success
    assert_template :new
  end

  def test_create_reply
    comment = comments(:default)
    blog_post = comment.parent
    assert_difference 'Comment.count' do
      post :create, :comment => {
        :blog_post_id => blog_post.to_param,
        :parent_id    => comment.to_param,
        :parent_type  => 'Comment',
        :name         => 'Test Reply',
        :content      => 'This is a reply'
      }
    end
    assert assigns(:comment)
    assert_response :redirect
    assert_redirected_to blog_post_path(blog_post)
  end

  def test_create_reply_failure
    assert_no_difference 'Comment.count' do
      post :create, :blog_post_id => blog_posts(:default).to_param, 
                    :id => comments(:default).to_param
    end
    assert assigns(:comment)
    assert_response :success
    assert_template :new
  end
end
