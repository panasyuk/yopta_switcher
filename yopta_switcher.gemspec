# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yopta_switcher/version'

Gem::Specification.new do |spec|
  spec.name          = 'yopta_switcher'
  spec.version       = YoptaSwitcher::VERSION
  spec.authors       = ['Alexander Panasyuk']
  spec.email         = ['panasmeister@gmail.com']

  spec.summary       = 'Enables automation of switching subscription terms'
  spec.description   = 'Switches Internet access subscription terms. Works for one anonymous ISP.'
  spec.homepage      = 'https://github.com/panasyuk/yopta_switcher'
  spec.license       = 'MIT'

  spec.files         =  Dir.glob(File.join(File.dirname(__FILE__), 'lib/**/*'))

  spec.bindir        = 'exe'
  spec.executables   = ['yopta_switcher']
  spec.require_paths = ['lib']

  spec.add_dependency 'selenium-webdriver', '~> 3.4'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.4'
  spec.add_development_dependency 'guard', '~> 2.14'
  spec.add_development_dependency 'guard-minitest', '~> 2.4'
  spec.add_development_dependency 'minitest-stub_any_instance', '1.0.1'
end
