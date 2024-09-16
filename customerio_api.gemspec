# frozen_string_literal: true

require_relative 'lib/customerio_api/version'

Gem::Specification.new do |spec|
  spec.name = 'customerio_api'
  spec.version = CustomerioAPI::VERSION
  spec.authors = ['linhho0702']
  spec.email = ['hplinh0702@gmail.com']

  spec.summary = 'Customer.io API Wrapper'
  spec.homepage = 'https://github.com/PostCo/customerio_api'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org/'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/PostCo/customerio_api'
  spec.metadata['changelog_uri'] = 'https://github.com/PostCo/customerio_api/releases'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html

  spec.add_dependency 'activesupport', '~> 7.0.8'
  spec.add_dependency 'faraday', '~> 2.7.11'
  spec.add_dependency 'zeitwerk', '~> 2.6'
  spec.add_development_dependency('webmock', '~> 3.23.0')

  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec'
end
