# frozen_string_literal: true

require_relative 'lib/socials_regex/version'

Gem::Specification.new do |spec|
  spec.name = 'socials_regex'
  spec.version = SocialsRegex::VERSION
  spec.authors = ['talaatmagdyx']
  spec.email = ['talaatmagdy75@gmail.com']

  spec.summary = 'Social Account Detection and Extraction for Ruby'
  spec.description = 'Detect and extract URLs of social accounts:
throw in URLs, get back URLs of social media profiles by type.'
  spec.homepage = 'https://github.com/talaatmagdyx/socials_regex'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['documentation_uri'] = 'https://github.com/talaatmagdyx/socials_regex/wiki'
  spec.metadata['source_code_uri'] = 'https://github.com/talaatmagdyx/socials_regex'
  spec.metadata['changelog_uri'] = 'https://github.com/talaatmagdyx/socials_regex/blob/master/CHANGELOG.md'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/talaatmagdyx/socials_regex/issues'
  spec.metadata['wiki_uri'] = 'https://github.com/talaatmagdyx/socials_regex/wiki'
  spec.post_install_message = 'Thanks for installing!'
  spec.platform = Gem::Platform::RUBY

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?('bin/', 'test/', 'spec/', 'features/', '.git',
                                                         '.circleci', 'appveyor')
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html

  spec.metadata['rubygems_mfa_required'] = 'true'
end
