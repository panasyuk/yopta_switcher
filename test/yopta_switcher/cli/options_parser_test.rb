require 'test_helper'
require 'yopta_switcher/cli/options'
require 'yopta_switcher/cli/options_parser'

class OptionsParserTest < Minitest::Test
  attr_reader :argv, :options, :parser
  def setup
    @options = YoptaSwitcher::CLI::Options.new
    @argv = []
    parser_class = YoptaSwitcher::CLI::OptionsParser
    @parser = nil
    parser_class.stub_any_instance(:define_options, true) do
      @parser =
        parser_class.new(argv: argv, options: options)
    end
  end

  def test_respond_to_argv
    assert_respond_to parser, :argv
  end

  def test_argv
    assert_equal parser.argv.__id__, argv.__id__
  end

  def test_respond_to_options
    assert_respond_to parser, :options
  end

  def test_options
    assert_equal parser.options.__id__, options.__id__
  end

  def test_parse_sets_login_url_option
    parse_sets_option('-u', 'login_url', 'https://example.com/')
  end

  def test_parse_raises_error_if_login_url_is_not_uri_string
    expected_url = '!@@https:/example.com0non-uri__'
    argv.push('-u', expected_url)
    parser.define_options

    assert_raises URI::InvalidURIError do
      parser.parse!
    end
  end

  def test_parse_sets_login_option
    parse_sets_option('-l', 'login', 'some login')
  end

  def test_parse_sets_password_option
    parse_sets_option('-p', 'password', 'some password')
  end

  def test_parse_sets_wait_option
    parse_sets_option('-w', 'wait_timeout', '3', 3)
  end

  def test_parse_sets_default_wait_option
    parse_sets_default_option('wait_timeout', 10)
  end

  def test_parse_sets_turn_on_operation_class_option
    parse_sets_option('-o', 'operation_class', 'turn_on',
                      YoptaSwitcher::Operations::TurnOn)
  end

  def test_parse_sets_turn_off_operation_class_option
    parse_sets_option('-o', 'operation_class', 'turn_off',
                      YoptaSwitcher::Operations::TurnOff)
  end

  def test_parse_sets_default_operation_class_option
    parse_sets_default_option('operation_class',
                              YoptaSwitcher::Operations::TurnOn)
  end

  def test_parse_raises_error_if_unknown_operation_passed
    parse_raises_error_if_unknown_option_passed('-o')
  end

  def test_parse_sets_phantomjs_browser_option
    parse_sets_option('-b', 'browser', 'phantomjs', :phantomjs)
  end

  def test_parse_sets_firefox_browser_option
    parse_sets_option('-b', 'browser', 'firefox', :firefox)
  end

  def test_parse_sets_default_browser_option
    parse_sets_default_option('browser', :phantomjs)
  end

  def test_parse_raises_error_if_unknown_browser_passed
    parse_raises_error_if_unknown_option_passed('-b')
  end

  private

  def parse_raises_error_if_unknown_option_passed(flag)
    unexpected_value = 'unknown'
    argv.push(flag, unexpected_value)
    parser.define_options

    assert_raises OptionParser::InvalidArgument do
      parser.parse!
    end
  end

  def parse_sets_option(flag, name, input, output = input)
    expected_value = input
    argv.push(flag, expected_value)
    parser.define_options

    parser.parse!

    assert_equal output, options.public_send(name)
  end

  def parse_sets_default_option(name, value)
    parser.define_options
    parser.parse!
    assert_equal value, options.public_send(name)
  end
end
