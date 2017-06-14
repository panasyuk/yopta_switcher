module YoptaSwitcher
  class Client
    DEFAULT_CLICKS_NUMBER = 15

    attr_reader :driver, :login_url

    def initialize(driver:, login_url:)
      @driver = driver
      @login_url = login_url
    end

    def login(login:, password:)
      driver.visit(login_url)

      username_element = driver.find_element(name: 'login')
      driver.clear(username_element)
      driver.fill_in(username_element, login)

      password_element = driver.find_element(name: 'password')
      driver.clear(password_element)
      driver.fill_in(password_element, password)

      driver.submit(password_element)
    end

    def set_lowest_subscription_level(clicks_number = DEFAULT_CLICKS_NUMBER)
      decrease_button =
        driver.wait { driver.find_element(css: 'div.decrease a') }
      increase_button = driver.find_element(css: 'div.increase a')
      clicks_number.times do
        driver.click(decrease_button)
      end
      driver.click(increase_button)
    end

    def set_highest_subscription_level(clicks_number = DEFAULT_CLICKS_NUMBER)
      increase_button =
        driver.wait { driver.find_element(css: 'div.increase a') }
      decrease_button = driver.find_element(css: 'div.decrease a')
      clicks_number.times do
        driver.click(increase_button)
      end
    end

    def apply_selected_subscription_level
      apply_button =
        driver.wait { driver.find_element(css: '.main-offer .tariff a.btn') }

      driver.click(apply_button)
      driver.wait do
        driver.
          find_element(
            css: '.main-offer .tariff .tarriff-info .message-wrapper'
          )
      end
    end

    def logout
      logout_button_text = 'Выход'
      logout_button = driver.find_element(link_text: logout_button_text)
      driver.click(logout_button)
    end

    def quit
      driver.quit
    end
  end
end
