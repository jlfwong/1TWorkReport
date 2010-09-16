require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  def test_fixture_validity
    assert_fixture_validity :user
  end

  def test_validation_username
    user = User.new(users(:default).attributes)
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
    user = User.new(users(:default).attributes)
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
    user = users(:default)
    assert_equal 'hello', user.username
    assert_equal User.password_hash('hello','world'), user.password
    assert_equal users(:default).id, User.authenticate('hello','world').id
  end

  def test_password_hash_generation
    user = User.new(
      :username     => 'username',
      :password_raw => 'password'
    )
    user.save!
    assert_equal user.password, User.password_hash('username','password')
  end
end
