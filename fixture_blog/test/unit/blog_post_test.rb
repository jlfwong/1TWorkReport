require File.dirname(__FILE__) + '/../test_helper'

class BlogPostTest < ActiveSupport::TestCase
  def test_fixture_validity
    assert_fixture_validity :blog_post
  end

  def test_validation_title
    blog_post = blog_posts(:default)
    assert blog_post.valid?

    blog_post.title = ''
    assert blog_post.invalid?
    assert_has_errors_on blog_post, :title

    blog_post.title = 'A' * 4
    assert blog_post.invalid?
    assert_has_errors_on blog_post, :title

    blog_post.title = 'A' * 51
    assert blog_post.invalid?
    assert_has_errors_on blog_post, :title
  end

  def test_validation_content
    blog_post = blog_posts(:default)
    assert blog_post.valid?

    blog_post.content = ''
    assert blog_post.invalid?

    blog_post.content = 'something'
    assert blog_post.valid?
  end

  def test_scope_published
    assert BlogPost.published.include? blog_posts(:published)
    assert !(BlogPost.published.include? blog_posts(:unpublished))
  end
end
