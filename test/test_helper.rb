$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'yopta_switcher'
require 'minitest/autorun'
require 'minitest/stub_any_instance'
require 'pry-byebug'

require 'support/driver_adapter_interface'