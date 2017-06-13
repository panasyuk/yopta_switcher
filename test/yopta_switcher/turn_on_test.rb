require 'test_helper'

class TurnOnTest < Minitest::Test
  attr_reader :service, :client, :login, :password

  def setup
    @client = Minitest::Mock.new
    @login = Object.new
    @password = Object.new

    @service =
      YoptaSwitcher::TurnOn.new(
        client: client,
        login: login,
        password: password
      )
  end

  def test_respond_to_client
    assert_respond_to service, :client
  end

  def test_client_returns_client_param
    assert_equal service.client.__id__, client.__id__
  end

  def test_respond_to_login
    assert_respond_to service, :login
  end

  def test_login_returns_login_param
    assert_equal service.login, login
  end

  def test_respond_to_password
    assert_respond_to service, :password
  end

  def test_password_returns_password_param
    assert_equal service.password, password
  end

  def test_respond_to_call
    assert_respond_to service, :call
  end

  def test_call
    client.
      expect(:login, nil, [{login: login, password: password}])
    client.expect(:set_highest_subscription_level, nil)
    client.expect(:apply_selected_subscription_level, nil)
    client.expect(:logout, nil)
    client.expect(:quit, nil)

    service.call

    client.verify
  end
end
