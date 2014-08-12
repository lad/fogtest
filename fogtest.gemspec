Gem::Specification.new do |spec|
  spec.name          = "fogtest"
  spec.homepage      = "https://confluence.workday.com/display/PENG/Skynet"
  spec.license       = "Proprietary"
  spec.version       = '0.0.1'
  spec.description   = 'Simple fog gem test'
  spec.summary       = 'Test fog gem interaction with WPC and AWS'
  spec.authors       = 'Production Engineering'
  spec.email         = ['dev.tools.scrum.peng@workday.com']

  spec.files         = Dir['bin/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "docopt"
  spec.add_dependency "fog", '= 1.23.0'

  spec.add_development_dependency 'pry'
end
