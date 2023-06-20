# frozen_string_literal: true

require_relative 'socials_regex/version'

module SocialsRegex
  autoload :Error, 'socials_regex/error'
  autoload :Platforms, 'socials_regex/platforms'
  autoload :Regexes, 'socials_regex/platforms'
end
