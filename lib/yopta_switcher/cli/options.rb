module YoptaSwitcher
  module CLI
    Options =
      Struct.new(
        :login_url,
        :login,
        :password,
        :wait_timeout,
        :browser,
        :operation_class
      )
  end
end
