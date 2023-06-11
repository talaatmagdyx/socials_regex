# frozen_string_literal: true

module SocialsRegex
  class Platforms
    PLATFORM_FACEBOOK = 'facebook'
    PLATFORM_GITHUB = 'github'
    PLATFORM_LINKEDIN = 'linkedin'
    PLATFORM_TWITTER = 'twitter'
    PLATFORM_INSTAGRAM = 'instagram'
    PLATFORM_YOUTUBE = 'youtube'
    PLATFORM_EMAIL = 'email'
    PLATFORM_HACKER_NEWS = 'hackernews'
    PLATFORM_MEDIUM = 'medium'
    PLATFORM_PHONE = 'phone'
    PLATFORM_REDDIT = 'reddit'
    PLATFORM_SKYPE = 'skype'
    PLATFORM_SNAPCHAT = 'snapchat'
    PLATFORM_STACKEXCHANGE = 'stackexchange'
    PLATFORM_STACKOVERFLOW = 'stackoverflow'
    PLATFORM_TELEGRAM = 'telegram'
    PLATFORM_VIMEO = 'vimeo'
    PLATFORM_XING = 'xing'
    PLATFORM_ANGELLIST = 'angellist'
    PLATFORM_CRUNCHBASE = 'crunchbase'
  end

  class Regexes
    ANGELLIST_URL_REGEX = {
      # https://angel.co/company/twitter, https://angel.co/company/twitter/culture
      company: %r{(?:https?:)?//angel\.co/company/(?<company>[A-Za-z0-9_-]+)(?:/(?<company_subpage>[A-Za-z0-9-]+))?},
      # https://angel.co/company/twitter/jobs/576275-engineering-manager
      job: %r{(?:https?:)?//angel\.co/company/(?<company>[A-Za-z0-9_-]+)
           /jobs/(?<job_permalink>(?<job_id>[0-9]+)-(?<job_slug>[A-Za-z0-9-]+))}x,
      # https://angel.co/p/naval, https://angel.co/u/karllorey
      user: %r{(?:https?:)?//angel\.co/(?<type>u|p)/(?<user>[A-Za-z0-9_-]+)}
    }.freeze

    CRUNCHBASE_URL_REGEX = {
      # http://crunchbase.com/organization/acme-corp
      company: %r{(?:https?:)?//crunchbase\.com/organization/(?<organization>[A-Za-z0-9_-]+)},
      # http://crunchbase.com/person/karl-lorey
      person: %r{(?:https?:)?//crunchbase\.com/person/(?<person>[A-Za-z0-9_-]+)}
    }.freeze

    EMAIL_URL_REGEX = {
      # jeff@amazon.com, mailto:jeff@amazon.com, mailto:plususer+test@gmail.com
      email: /(?:mailto:)?(?<email>[A-Za-z0-9_.+-]+@[A-Za-z0-9_.-]+\.[A-Za-z]+)/
    }.freeze

    FACEBOOK_URL_REGEX = {
      # http://fb.com/peter_parker-miller, https://facebook.com/peter.parker, https://facebook.com/peterparker
      profile_by_username: %r{(?:https?:)?//(?:www\.)?(?:facebook|fb)\.com/(?<profile>(?![A-Za-z]+\.php)
(?!marketplace|gaming|watch|me|messages|help|search|groups)[A-Za-z0-9_\-.]+)/?}x,
      # https://www.facebook.com/100004123456789, https://www.facebook.com/profile.php?id=100004123456789
      profile_by_id: /(?:https?:)?\/\/(?:www\.)?facebook\.com\/(?:profile\.php\?id=)?(?<id>[0-9]+)/
    }.freeze
  end
end
