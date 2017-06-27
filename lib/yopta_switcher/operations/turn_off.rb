module YoptaSwitcher
  module Operations
    class TurnOff
      attr_reader :client, :login, :password

      def initialize(client:, login:, password:)
        @client = client
        @login = login
        @password = password
      end

      def call
        client.login(login: login, password: password)
        client.set_lowest_subscription_level
        client.apply_selected_subscription_level
        client.logout
        client.quit
      end
    end
  end
end
