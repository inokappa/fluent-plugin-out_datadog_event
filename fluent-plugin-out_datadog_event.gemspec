# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluent/plugin/out_datadog_event/version'

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-out_datadog_event"
  spec.version       = Fluent::Plugin::OutDatadogEvent::VERSION
  spec.authors       = ["Yohei Kawahara(inokappa)"]
  spec.email         = [""]

  spec.summary       = %q{fluentd output plugin for datadog event}
  spec.description   = %q{fluentd output plugin for datadog event}
  spec.homepage      = "http://inokara.hateblo.jp/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "dogapi"
end
