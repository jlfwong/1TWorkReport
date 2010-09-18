require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < ActiveSupport::TestCase
  def test_factory_validity
    assert_factory_validity :comment, :comment_reply
  end

  def test_validation_name
    comment = Factory(:comment)
    comment.name = ''
    assert comment.invalid?
    assert_has_errors_on comment, :name

    comment.name = 'a' * 30
    assert comment.invalid?
    assert_has_errors_on comment, :name

    comment.name = '?!#*$'
    assert comment.invalid?
    assert_has_errors_on comment, :name

    comment.name = 'some guy'
    assert comment.valid?
  end

  def test_validation_parent
    comment = Factory(:comment)
    comment.parent = nil
    assert comment.invalid?

    comment.parent_id = comment.id
    comment.parent_type = 'Comment'
    assert comment.invalid?

    comment.parent = Factory(:unpublished_blog_post)
    assert comment.invalid?

    comment.parent = Factory(:published_blog_post)
    assert comment.valid?
  end

  def test_validation_content
    comment = Factory(:comment)
    comment.content = ''
    assert comment.invalid?
    assert_has_errors_on comment, :content

    comment.content = 'A' * 4000
    assert comment.invalid?
    assert_has_errors_on comment, :content
  end
end
