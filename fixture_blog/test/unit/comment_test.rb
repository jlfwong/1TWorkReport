require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < ActiveSupport::TestCase
  def test_fixture_validity
    assert_fixture_validity :comment
  end

  def test_validation_name
    comment = comments(:default)
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
    comment = comments(:reply)  
    comment.parent = nil
    assert comment.invalid?

    comment.parent_id = comment.id
    comment.parent_type = 'Comment'
    assert comment.invalid?

    comment.parent = blog_posts(:unpublished)
    assert comment.invalid?

    comment.parent = blog_posts(:published)
    assert comment.valid?
  end

  def test_validation_content
    comment = comments(:default)
    comment.content = ''
    assert comment.invalid?
    assert_has_errors_on comment, :content

    comment.content = 'A' * 4000
    assert comment.invalid?
    assert_has_errors_on comment, :content
  end
end
