ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Example usage:
  #   assert_factory_validity :factory_name_1, :factory_name_2
  def assert_factory_validity(*factories)
    factories.each do |factory|
      model = Factory.build(factory.to_sym)
      assert model.valid?, "
        Factory :#{factory} is invalid: #{model.errors.inspect} #{model.attributes.inspect}
      ".strip
    end
  rescue ActiveRecord::RecordInvalid => e
    raise e.to_s + e.backtrace.to_yaml
  end

  # Example usage:
  #   assert_has_errors_on( @record, [:field_1, :field_2] )
  #   assert_has_errors_on( @record, {:field_1 => 'Message1', :field_2 => 'Message 2'} )
  def assert_has_errors_on(record, fields)
    fields = [fields].flatten unless fields.is_a?(Hash)
    fields.each do |field, message|
      assert record.errors.has_key?(field.to_sym), "#{record.class.name} should error on invalid #{field}"
      if message && record.errors[field].is_a?(Array) && !message.is_a?(Array)
        assert_not_nil record.errors[field].index(message)
      elsif message
        assert_equal message, record.errors[field]
      end
    end
  end

  # Example usage:
  #   assert_body_contains 'Back to index'
  def assert_body_contains(str)
    assert_match str, @response.body, %("#{str}" not found in response body)
  end
end

module TestAuth
  def auth_encode(username, password)
    ActionController::HttpAuthentication::Basic.encode_credentials(username,password)
  end
end

class ActionController::TestCase
  include TestAuth
  def login(username = 'admin', password = 'admin')
    @request.env['HTTP_AUTHORIZATION'] = auth_encode(username,password)
  end
end

class ActionDispatch::IntegrationTest
  include TestAuth
  def auth_header(username = 'admin', password = 'admin')
    {'HTTP_AUTHORIZATION' => auth_encode(username,password)}
  end
end

