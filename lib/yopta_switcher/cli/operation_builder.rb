require 'selenium-webdriver'
require 'yopta_switcher'

module YoptaSwitcher
  module CLI
    class OperationBuilder
      attr_reader :client, :driver, :options, :operation

      def initialize(options)
        @options = options
        @driver = build_driver(options)
        @client = build_client(@driver, options)
      end

      def build
        @operation ||=
          options.
            operation_class.
            new(
              client: client,
              login: options.login,
              password: options.password
            )
      end

      private

      def build_driver(options)
        wait = wait_class.new(timeout: options.wait_timeout)
        driver = webdriver_class.for(options.browser)
        driver_adapter_class.new(driver: driver, wait_instance: wait)
      end

      def build_client(driver, options)
        client_class.new(
          driver: driver,
          login_url: options.login_url
        )
      end

      def client_class
        YoptaSwitcher::Client
      end

      def wait_class
        Selenium::WebDriver::Wait
      end

      def webdriver_class
        Selenium::WebDriver
      end

      def driver_adapter_class
        YoptaSwitcher::SeleniumDriverAdapter
      end
    end
  end
end
