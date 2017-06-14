require 'test_helper'

class ClientTest < Minitest::Test
  attr_reader :client, :driver, :login_url

  def setup
    @driver = Minitest::Mock.new
    @login_url = Object.new
    @client =
      YoptaSwitcher::Client.new(
        driver: driver,
        login_url: login_url
      )
  end

  def test_class_has_DEFAULT_CLICKS_NUMBER_constant
    assert YoptaSwitcher::Client.const_defined?(:DEFAULT_CLICKS_NUMBER)
  end

  def test_DEFAULT_CLICKS_NUMBER_constant_equals_15
    assert_equal YoptaSwitcher::Client::DEFAULT_CLICKS_NUMBER, 15
  end

  def test_respond_to_driver
    assert_respond_to client, :driver
  end

  def test_driver_returns_driver_param
    assert_equal client.driver.__id__, driver.__id__
  end

  def test_respond_to_login_url
    assert_respond_to client, :login_url
  end

  def test_login_url_returns_login_url_param
    assert_equal client.login_url, login_url
  end

  def test_respond_to_login
    assert_respond_to client, :login
  end

  def test_login
    login = Object.new
    password = Object.new
    username_element = Object.new
    password_element = Object.new

    driver.expect(:visit, true, [login_url])
    driver.expect(:find_element, username_element, [{name: 'login'}])
    driver.expect(:clear, true, [username_element])
    driver.expect(:fill_in, true, [username_element, login])
    driver.expect(:find_element, password_element, [{name: 'password'}])
    driver.expect(:clear, true, [password_element])
    driver.expect(:fill_in, true, [password_element, password])
    driver.expect(:submit, true, [password_element])

    client.login(login: login, password: password)

    driver.verify
  end

  def test_respond_to_set_lowest_subscription_level
    assert_respond_to client, :set_lowest_subscription_level
  end

  def test_set_lowest_subscription_level
    decrease_button = Object.new
    increase_button = Object.new

    driver.expect(:find_element, decrease_button, [{css: 'div.decrease a'}])
    driver.expect(:find_element, increase_button, [{css: 'div.increase a'}])
    driver.
      expect(:wait, decrease_button) { |&block| block.call === decrease_button }
    3.times { driver.expect(:click, nil, [decrease_button]) }
    driver.expect(:click, nil, [increase_button])

    client.set_lowest_subscription_level(3)

    driver.verify
  end

  def test_respond_to_set_highest_subscription_level
    assert_respond_to client, :set_highest_subscription_level
  end

  def test_set_highest_subscription_level
    increase_button = Object.new
    decrease_button = Object.new

    driver.expect(:find_element, increase_button, [{css: 'div.increase a'}])
    driver.expect(:find_element, decrease_button, [{css: 'div.decrease a'}])
    driver.
      expect(:wait, increase_button) { |&block| block.call === increase_button }
    3.times { driver.expect(:click, nil, [increase_button]) }

    client.set_highest_subscription_level(3)

    driver.verify
  end

  def test_respond_to_apply_selected_subscription_level
    assert_respond_to client, :apply_selected_subscription_level
  end

  def test_apply_selected_subscription_level
    apply_button = Object.new
    message_element = Object.new

    driver.
      expect(:find_element, apply_button, [{css: '.main-offer .tariff a.btn'}])
    driver.
      expect(
        :find_element,
        message_element,
        [{css: '.main-offer .tariff .tarriff-info .message-wrapper'}]
      )
    driver.expect(:wait, apply_button) { |&block| block.call === apply_button }
    driver.expect(:wait, true) { |&block| block.call === message_element }
    driver.expect(:click, nil, [apply_button])

    client.apply_selected_subscription_level

    driver.verify
  end

  def test_respond_to_logout
    assert_respond_to client, :logout
  end

  def test_logout_finds_logout_button_and_clicks_it
    logout_button_text = 'Выход'

    logout_button = Object.new

    driver.
      expect(:find_element, logout_button, [{link_text: logout_button_text}])
    driver.expect(:click, nil, [logout_button])

    client.logout

    driver.verify
  end

  def test_quit
    driver.expect(:quit, nil)

    client.quit

    driver.verify
  end
end
