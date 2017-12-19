lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scanner/version'

Gem::Specifivation.new do |spec|
	spec.name    = 'scanenr'
	spec.version = Scanner::VERSION

	spec.add_dependency 'event_store'
end

