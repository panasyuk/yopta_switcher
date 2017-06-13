require 'test_helper'

class SelenimDriverAdapterTest < Minitest::Test
  include DriverAdapterInterface

  attr_reader :adapter, :driver, :wait_instance

  def setup
    @driver = Minitest::Mock.new
    @wait_instance = Minitest::Mock.new
    @adapter =
      YoptaSwitcher::SeleniumDriverAdapter.
      new(driver: driver, wait_instance: wait_instance)
  end

  def test_respond_to_driver
    assert_respond_to adapter, :driver
  end

  def test_driver_returns_driver_argument
    assert_equal adapter.driver.__id__, driver.__id__
  end

  def test_wait_instance_returns_wait_instance_argument
    assert_equal adapter.wait_instance.__id__, wait_instance.__id__
  end

  def test_visit
    url = Object.new
    navigate_result = Minitest::Mock.new
    navigate_result.expect(:to, true, [url])
    driver.expect(:navigate, navigate_result)

    adapter.visit(url)

    driver.verify
    navigate_result.verify
  end

  def test_wait
    block = Proc.new { true }
    wait_instance.expect(:until, true, &block)

    adapter.wait(&block)

    wait_instance.verify
  end

  def test_fill_in
    input_string = String.new
    element = Minitest::Mock.new

    element.expect(:send_keys, true, [input_string])

    adapter.fill_in(element, input_string)

    element.verify
  end

  def test_find_element
    finder_args = Hash.new
    driver.expect(:find_element, true, [finder_args])

    adapter.find_element(finder_args)

    driver.verify
  end

  def test_click
    element = Minitest::Mock.new
    element.expect(:click, true)

    adapter.click(element)

    element.verify
  end

  def test_submit
    element = Minitest::Mock.new
    element.expect(:submit, true)

    adapter.submit(element)

    element.verify
  end

  def test_clear
    element = Minitest::Mock.new
    element.expect(:clear, true)

    adapter.clear(element)

    element.verify
  end

  def test_quit
    driver.expect(:quit, nil)

    adapter.quit

    driver.verify
  end
end
