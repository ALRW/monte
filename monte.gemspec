# frozen_string_literal: true

require_relative 'lib/monte/version'

Gem::Specification.new do |spec|
  spec.name          = 'monte'
  spec.license       = 'MIT'
  spec.version       = Monte::VERSION
  spec.authors       = ['Andrew Werner']
  spec.email         = ['awerner1@googlemail.com']

  spec.summary       = 'Monte Carlo forecasting for engineering projects'
  spec.description   = "If you are an engineer who is being asked, 'When will
  it be done?' then Monte can help by using the Monte Carlo method to provide
  you with plausile forecasts based on historic data."
  spec.homepage      = 'https://github.com/ALRW/monte'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/ALRW/monte.git'
  spec.metadata['changelog_uri'] = 'https://github.com/ALRW/monte/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
