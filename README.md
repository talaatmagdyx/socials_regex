# SocialsRegex

----
Social Regex Account Detection and Extraction for Ruby. Detect and extract URLs of social accounts: throw in URLs, get back URLs of social media profiles by type.

Features:

- detect the platform a url points to (all major platforms supported)
- extract the information contained within the url (without opening the url, of course)
- extract emails and phone numbers from hyperlinks

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add socials_regex

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install socials_regex

### Requirements
This gem requires Ruby 2.6+

## Usage

```ruby
require 'socials_regex'

supported_platforms = SocialsRegex::Platforms.all
# [:PLATFORM_FACEBOOK, :PLATFORM_GITHUB, :PLATFORM_LINKEDIN, :PLATFORM_TWITTER, :PLATFORM_INSTAGRAM, :PLATFORM_YOUTUBE, 
# :PLATFORM_EMAIL, :PLATFORM_HACKER_NEWS, :PLATFORM_MEDIUM, :PLATFORM_PHONE, :PLATFORM_REDDIT,
# :PLATFORM_SKYPE, :PLATFORM_SNAPCHAT, :PLATFORM_STACKEXCHANGE, :PLATFORM_STACKOVERFLOW, :PLATFORM_STACKOVERFLOW, 
# :PLATFORM_TELEGRAM, :PLATFORM_VIMEO, :PLATFORM_XING, :PLATFORM_ANGELLIST, :PLATFORM_CRUNCHBASE, 
# :PLATFORM_STACKEXCHANGE_NETWORK, :PLATFORM_WHATSAPP, :PLATFORM_YELP]


supported_regexes = SocialsRegex::Regexes.all
# [:ANGELLIST_URL_REGEX, :CRUNCHBASE_URL_REGEX, :EMAIL_URL_REGEX, :FACEBOOK_URL_REGEX, :GITHUB_URL_REGEX, :HACKERNEWS_URL_REGEX,
# :INSTAGRAM_URL_REGEX, :LINKEDIN_URL_REGEX, :MEDIUM_URL_REGEX, :PHONE_URL_REGEX, :REDDIT_URL_REGEX, :SKYPE_URL_REGEX, :SNAPCHAT_URL_REGEX,
# :STACKEXCHANGE_URL_REGEX, :STACKEXCHANGE_NETWORK_URL_REGEX, :STACKOVERFLOW_URL_REGEX, :TELEGRAM_URL_REGEX, :TWITTER_URL_REGEX,
# :VIMEO_URL_REGEX, :XING_URL_REGEX, :YOUTUBE_URL_REGEX, :WHATSAPP_URL_REGEX, :YELP_URL_REGEX] 

# get all regex for all regex
platform_regexes = SocialsRegex::Socials::PLATFORMS_REGEX
# example [:yelp, {:company=>/(?:https?:\/\/)?(?:www\.)?yelp\.com\/biz\/(?<company>[A-Za-z0-9_-]+)/}] 

# get regex for specific platforms 
twitter_regex = SocialsRegex::Socials::PLATFORMS_REGEX[:twitter]
# {:status=>/(?:https?:)?\/\/(?:[A-Za-z]+\.)?twitter\.com\/@?(?<username>[A-Za-z0-9_]+)\/status\/(?<tweet_id>[0-9]+)\/?/,
# :user=>/(?:https?:)?\/\/(?:[A-Za-z]+\.)?twitter\.com\/@?(?!home|share|privacy|tos)(?<username>[A-Za-z0-9_]+)\/?/}


# how to extract social data from links or texts
text = 'https://twitter.com/karllorey/status/1259924082067374088' \
             'https://twitter.com/karllorey12/status/12599240820673740883' \
             'http://crunchbase.com/organization/acme-corp jeff@amazon.com mailto:plususer+test@gmail.com' \
             'https://facebook.com/peter.parker https://www.facebook.com/profile.php?id=100004123456789' \
             'https://github.com/talaatmagdyx https://github.com/talaatmagdyx/socials_regex' \
             'https://news.ycombinator.com/item?id=23290375 https://instagram.com/__disco__dude' \
             'https://www.linkedin.com/in/talaatmagdyx/ https://medium.com/does-exist/some-post-123abc'
extract = SocialsRegex::Extraction.new(text: text)
# #<SocialsRegex::Extraction:0x00007f5c51d0c488 @text= "https://twitter.com/karllorey/status/......">

# to extract all links and data 
extract.extract_matches_per_platform
# {:crunchbase=>{:company=>[{:matched=>"http://crunchbase.com/organization/acme-corp", "organization"=>"acme-corp"}]},
# :medium=>{:post=>[{:matched=>"https://medium.com/does-exist/some-post-123abc", "username"=>nil, "publication"=>"does-exist", "slug"=>"some-post", "post_id"=>"123abc"}]},
#   :hackernews=>{:item=>[{:matched=>"https://news.ycombinator.com/item?id=23290375", "item"=>"23290375"}]},
#  :email=>{:email=>[{:matched=>"jeff@amazon.com", "email"=>"jeff@amazon.com"}, {:matched=>"mailto:plususer+test@gmail.comhttps", "email"=>"plususer+test@gmail.comhttps"}]},
#    :instagram=>{:profile=>[{:matched=>"https://instagram.com/__disco__dudehttps", "username"=>"__disco__dudehttps"}]},


# to extract links or data using specific platform like instagram
extract.extract_matches_by_platform(platform: 'instagram') # or use :instagram
# {"instagram"=>{:profile=>[{:matched=>"https://instagram.com/__disco__dudehttps", "username"=>"__disco__dudehttps"}]}}

# to extract links or data using specific regex like twitter status
matches = extract.extract_matches_by_regex(regex: SocialsRegex::Regexes::TWITTER_URL_REGEX[:status])
# [{:matched=>"https://twitter.com/karllorey/status/1259924082067374088", "username"=>"karllorey", "tweet_id"=>"1259924082067374088"},
# {:matched=>"https://twitter.com/karllorey12/status/12599240820673740883", "username"=>"karllorey12", "tweet_id"=>"12599240820673740883"}]


```

# References
- [social-media-profiles-regexs](https://github.com/lorey/social-media-profiles-regexs):
  extract urls of social media profiles with regular expressions

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [Contributing](https://github.com/talaatmagdyx/socials_regex/blob/master/.github/CONTRIBUTING.md). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/talaatmagdyx/socials_regex/blob/master/.github/CODE_OF_CONDUCT.md).

## [ChangeLog](./CHANGELOG.md)

## Reporting Bugs / Feature Requests

Please [open an Issue on GitHub](https://github.com/talaatmagdyx/socials_regex/issues) if you have feedback, new feature requests, or want to report a bug. Thank you!

## Pull Request
Please read [Contributing](https://github.com/talaatmagdyx/socials_regex/blob/master/.github/PULL_REQUEST_TEMPLATE.md)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SocialsRegex project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/talaatmagdyx/socials_regex/blob/master/.github/CODE_OF_CONDUCT.md).
