require 'yopta_switcher/cli/options'

class CLIOptionsTest < Minitest::Test
  attr_reader :options

  def setup
    @options = YoptaSwitcher::CLI::Options.new
  end

  def test_respond_to_login_url
    assert_respond_to options, :login_url
  end

  def test_respond_to_login_url=
    assert_respond_to options, :login_url=
  end

  def test_login_url
    value = Object.new
    options.login_url = value
    assert_equal options.login_url, value
  end

  def test_respond_to_login
    assert_respond_to options, :login
  end

  def test_respond_to_login=
    assert_respond_to options, :login=
  end

  def test_login
    value = Object.new
    options.login = value
    assert_equal options.login, value
  end

  def test_respond_to_password
    assert_respond_to options, :password
  end

  def test_respond_to_password=
    assert_respond_to options, :password=
  end

  def test_password
    value = Object.new
    options.password = value
    assert_equal options.password, value
  end

  def test_respond_to_wait_timeout
    assert_respond_to options, :wait_timeout
  end

  def test_respond_to_wait_timeout=
    assert_respond_to options, :wait_timeout=
  end

  def test_wait_timeout
    value = Object.new
    options.wait_timeout = value
    assert_equal options.wait_timeout, value
  end

  def test_respond_to_browser
    assert_respond_to options, :browser
  end

  def test_respond_to_browser=
    assert_respond_to options, :browser=
  end

  def test_browser
    value = Object.new
    options.browser = value
    assert_equal options.browser, value
  end

  def test_respond_to_operation_class
    assert_respond_to options, :operation_class
  end

  def test_respond_to_operation_class=
    assert_respond_to options, :operation_class=
  end

  def test_operation_class
    value = Object.new
    options.operation_class = value
    assert_equal options.operation_class, value
  end
end
