require 'optparse'
require 'optparse/uri'

module YoptaSwitcher
  module CLI
    class OptionsParser
      OPERATION_NAME_TO_CLASS_MAPPING = {
        'turn_on' => YoptaSwitcher::Operations::TurnOn,
        'turn_off' => YoptaSwitcher::Operations::TurnOff
      }.freeze

      BROWSER_MAPPING = {
        'phantomjs' => :phantomjs,
        'firefox' => :firefox
      }.freeze

      attr_reader :options, :argv, :parser

      def initialize(argv:, options:)
        @options = options
        @argv = argv
        @parser = OptionParser.new
        define_options
      end

      def define_options
        define_login_url_option
        define_login_option
        define_password_option
        define_wait_option
        define_operation_option
        define_browser_option
      end

      def parse!
        set_default_options
        parser.parse!(argv)
        options
      end

      private

      def set_default_options
        options.wait_timeout = 10
        options.browser = :phantomjs
        options.operation_class = YoptaSwitcher::Operations::TurnOn
      end

      def define_login_url_option
        parser.on('-u Login URL', URI) do |url|
          options.login_url = url.to_s
        end
      end

      def define_login_option
        parser.on('-l Login') do |login|
          options.login = login
        end
      end

      def define_password_option
        parser.on('-p Password') do |password|
          options.password = password
        end
      end

      def define_wait_option
        parser.on(
          '-w Wait timeout in seconds',
          OptionParser::DecimalInteger,
          '10'
        ) do |wait|
          options.wait_timeout = wait
        end
      end

      def define_operation_option
        parser.on(
          '-o Operation',
          OPERATION_NAME_TO_CLASS_MAPPING.keys,
          OPERATION_NAME_TO_CLASS_MAPPING.keys.join(', ')
        ) do |operation|
          options.operation_class = OPERATION_NAME_TO_CLASS_MAPPING[operation]
        end
      end

      def define_browser_option
        parser.on(
          '-b Browser',
          BROWSER_MAPPING.keys,
          BROWSER_MAPPING.values.join(', ')
        ) do |browser|
          options.browser = BROWSER_MAPPING[browser]
        end
      end
    end
  end
end
