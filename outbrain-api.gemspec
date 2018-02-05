# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'outbrain/api/version'

Gem::Specification.new do |spec|
  spec.name          = "outbrain-api"
  spec.version       = Outbrain::Api::VERSION
  spec.authors       = ["Nick Blanchet", "Ankur Gupta"]
  spec.email         = ["h55nick@gmail.com", "ankur@granularhq.com"]

  spec.summary       = %q{A simple threadsafe wrapper for the outbrain api}
  spec.description   = %q{A thread safe wrapper for the outbrain api.}
  spec.homepage      = "https://github.com/simplereach/outbrain-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("faraday")
  spec.add_runtime_dependency("json")
  spec.add_runtime_dependency("hashie")

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
