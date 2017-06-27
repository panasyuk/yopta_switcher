require 'yopta_switcher'
require 'yopta_switcher/cli/options'
require 'yopta_switcher/cli/options_parser'
require 'yopta_switcher/cli/operation_builder'

module YoptaSwitcher
  module CLI
    def self.run(argv = [])
      options_parser = OptionsParser.new(argv: argv, options: Options.new)
      options_parser.parse!
      options = options_parser.options

      operation_builder = OperationBuilder.new(options)
      operation_builder.build
      operation = operation_builder.operation

      operation.call
    end
  end
end
