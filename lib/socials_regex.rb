# frozen_string_literal: true

require_relative 'socials_regex/version'

# main start of gem
module SocialsRegex
  autoload :Platforms, 'socials_regex/platforms'
  autoload :Regexes, 'socials_regex/platforms'
end
