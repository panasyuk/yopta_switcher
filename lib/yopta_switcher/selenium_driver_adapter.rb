module YoptaSwitcher
  class SeleniumDriverAdapter
    attr_reader :driver, :wait_instance

    def initialize(driver:, wait_instance:)
      @driver = driver
      @wait_instance = wait_instance
    end

    def visit(url)
      driver.navigate.to(url)
    end

    def wait(&block)
      wait_instance.until(&block)
    end

    def fill_in(element, input_string)
      element.send_keys(input_string)
    end

    def find_element(finder_args)
      driver.find_element(finder_args)
    end

    def click(element)
      element.click
    end

    def submit(element)
      element.submit
    end

    def clear(element)
      element.clear
    end

    def quit
      driver.quit
    end
  end
end
