# frozen_string_literal: true

module SocialsRegex
  class Socials
    PLATFORMS_REGEX = {
      "#{SocialsRegex::Platforms::PLATFORM_YELP}": SocialsRegex::Regexes::YELP_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_WHATSAPP}": SocialsRegex::Regexes::WHATSAPP_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_STACKEXCHANGE_NETWORK}":
        SocialsRegex::Regexes::STACKEXCHANGE_NETWORK_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_CRUNCHBASE}": SocialsRegex::Regexes::CRUNCHBASE_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_ANGELLIST}": SocialsRegex::Regexes::ANGELLIST_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_XING}": SocialsRegex::Regexes::XING_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_VIMEO}": SocialsRegex::Regexes::VIMEO_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_TELEGRAM}": SocialsRegex::Regexes::TELEGRAM_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_STACKOVERFLOW}": SocialsRegex::Regexes::STACKOVERFLOW_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_STACKEXCHANGE}": SocialsRegex::Regexes::STACKEXCHANGE_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_SNAPCHAT}": SocialsRegex::Regexes::SNAPCHAT_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_SKYPE}": SocialsRegex::Regexes::SKYPE_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_REDDIT}": SocialsRegex::Regexes::REDDIT_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_PHONE}": SocialsRegex::Regexes::PHONE_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_MEDIUM}": SocialsRegex::Regexes::MEDIUM_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_HACKER_NEWS}": SocialsRegex::Regexes::HACKERNEWS_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_EMAIL}": SocialsRegex::Regexes::EMAIL_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_YOUTUBE}": SocialsRegex::Regexes::YOUTUBE_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_INSTAGRAM}": SocialsRegex::Regexes::INSTAGRAM_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_TWITTER}": SocialsRegex::Regexes::TWITTER_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_LINKEDIN}": SocialsRegex::Regexes::LINKEDIN_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_GITHUB}": SocialsRegex::Regexes::GITHUB_URL_REGEX,
      "#{SocialsRegex::Platforms::PLATFORM_FACEBOOK}": SocialsRegex::Regexes::FACEBOOK_URL_REGEX
    }.freeze

    ERROR_MSG_UNKNOWN_PLATFORM = "Unknown platform, expected one of #{PLATFORMS_REGEX.keys}"
  end

  # Extracted profiles.
  class Extraction
    attr_accessor :text

    def initialize(text:)
      @text = text
    end

    #  Get lists of profiles keyed by platform name.
    # :return: a dictionary with the platform as a key, and a list of the platform's profiles as values.
    def extract_matches_per_platform
      matches = {}
      Socials::PLATFORMS_REGEX.each do |platform, regexes|
        matches.merge!(platform_matches(regexes: regexes, platform: platform))
      end
      matches
    end

    # Find all matches for a specific regex.
    # :param regex: platform to search for.
    # :return: list of matches.
    def extract_matches_by_regex(regex:)
      matches(regex: regex)
    end

    # Find all matches for a specific platform.
    # :param platform: platform to search for.
    # :return: hash of list of matches.
    def extract_matches_by_platform(platform:)
      regexes = Socials::PLATFORMS_REGEX[platform.to_sym]
      raise Socials::ERROR_MSG_UNKNOWN_PLATFORM unless regexes

      platform_matches(regexes: regexes, platform: platform)
    end

    private

    # Find all matches for a specific platform.
    # :param regexes:
    # :params platform:
    # :return: hash of list of matches.
    def platform_matches(regexes:, platform:)
      matches = {}
      regexes.each do |key, regex|
        matched = matches(regex: regex)
        next if matched.empty?

        matches[platform] ||= {}
        matches[platform][key] = matched
      end
      matches
    end

    def matches(regex:)
      reformat_matches(matches: text.to_enum(:scan, regex).map { Regexp.last_match })
    end

    def reformat_matches(matches:)
      reformat = []
      matches.each do |match|
        reformat << { matched: match[0] }.merge!(match.named_captures)
      end
      reformat
    end
  end
end
