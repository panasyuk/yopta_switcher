require 'test_helper'
require 'yopta_switcher/cli/operation_builder'

class OperationBuilderTest < Minitest::Test
  attr_reader :options, :builder, :client, :driver

  def setup
    @options = Minitest::Mock.new
    @driver = Minitest::Mock.new
    @client = Minitest::Mock.new
    builder_class = YoptaSwitcher::CLI::OperationBuilder
    @builder =
      builder_class.stub_any_instance(:build_client, client) do
        builder_class.stub_any_instance(:build_driver, driver) do
          builder_class.new(@options)
        end
      end
  end

  def test_respond_to_client
    assert_respond_to builder, :client
  end

  def test_client
    assert_equal builder.client.__id__, client.__id__
  end

  def test_respond_to_driver
    assert_respond_to builder, :driver
  end

  def test_driver
    assert_equal builder.driver.__id__, driver.__id__
  end

  def test_respond_to_build
    assert_respond_to builder, :build
  end

  def test_build_instantiates_operation_class
    operation = Object.new
    login = Object.new
    password = Object.new
    operation_class = Minitest::Mock.new
    options.expect(:operation_class, operation_class)
    options.expect(:login, login)
    options.expect(:password, password)
    operation_class.
      expect(
        :new,
        operation,
        [{client: client, login: login, password: password}]
      )

    result = builder.build

    assert_equal operation, result

    options.verify
    operation_class.verify
  end

  def test_build_driver

  end

  def test_build_client
    login_url = Object.new
    client_class = Minitest::Mock.new

    options.expect(:login_url, login_url)
    client_class.expect(:new, client, [{driver: driver, login_url: login_url}])

    builder.stub(:client_class, client_class) do
      result = builder.send(:build_client, driver, options)
      assert_equal client.__id__, result.__id__
    end

    options.verify
  end

  def test_client_class
    actual_value = builder.send(:client_class)
    assert_equal YoptaSwitcher::Client, actual_value
  end

  def test_wait_class
    actual_value = builder.send(:wait_class)
    assert_equal Selenium::WebDriver::Wait, actual_value
  end

  def test_webdriver_class
    actual_value = builder.send(:webdriver_class)
    assert_equal Selenium::WebDriver, actual_value
  end

  def test_driver_adapter_class
    actual_value = builder.send(:driver_adapter_class)
    assert_equal YoptaSwitcher::SeleniumDriverAdapter, actual_value
  end
end
