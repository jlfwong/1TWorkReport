require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  def test_factory_validity
    assert_factory_validity :user
  end

  def test_validation_username
    first_user = Factory(:user)
    user = Factory.build(:user)

    user.username = first_user.username
    assert user.invalid?

    user.username = ''
    assert user.invalid?

    user.username = 'a' * 4
    assert user.invalid?

    user.username = 'hello?world'
    assert user.invalid?

    user.username = 'a' * 26
    assert user.invalid?
  end

  def test_validation_password
    user = Factory(:user)
    user.password = ''
    assert user.invalid?

    user.password = '*' * 32
    assert user.invalid?

    user.password = 'a' * 31
    assert user.invalid?

    user.password = 'a' * 33
    assert user.invalid?
  end

  def test_class_method_password_hash
    assert_equal "5378488116c9ba4f60e7ee6f42711fa1b2acd630", User.password_hash('hello','world')
  end

  def test_class_method_authenticate
    user = Factory(:user)
    assert_equal User.password_hash(user.username,user.password_raw), user.password
    assert_equal user.id, User.authenticate(user.username,user.password_raw).id
  end

  def test_password_hash_generation
    user = Factory(:user)
    assert_equal user.password, User.password_hash(user.username,user.password_raw)
  end
end

