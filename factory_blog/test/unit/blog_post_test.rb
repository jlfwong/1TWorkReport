require File.dirname(__FILE__) + '/../test_helper'

class BlogPostTest < ActiveSupport::TestCase
  def test_factory_validity
    assert_factory_validity :blog_post
  end

  def test_validation_title
    blog_post = Factory.build(:blog_post)
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
    blog_post = Factory.build(:blog_post)
    assert blog_post.valid?

    blog_post.content = ''
    assert blog_post.invalid?

    blog_post.content = 'something'
    assert blog_post.valid?
  end
end

