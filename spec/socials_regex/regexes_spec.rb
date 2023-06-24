# frozen_string_literal: true

RSpec.describe SocialsRegex::Regexes do
  context SocialsRegex::Platforms::PLATFORM_ANGELLIST do
    context 'with company validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'https://angel.co/company/twitter',
                                      regex: SocialsRegex::Regexes::ANGELLIST_URL_REGEX[:company])).to be true
      end

      it 'Invalid' do
        expect(described_class.match?(input_str: 'https://angel.co/company1/twitter',
                                      regex: SocialsRegex::Regexes::ANGELLIST_URL_REGEX[:company])).to be false
      end

      it 'Valid company_subpage' do
        expect(described_class.match?(input_str: 'https://angel.co/company/twitter/culture',
                                      regex: SocialsRegex::Regexes::ANGELLIST_URL_REGEX[:company])).to be true
      end
    end

    context 'with job validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'https://angel.co/company/twitter/jobs/576275-engineering-manager',
                                      regex: SocialsRegex::Regexes::ANGELLIST_URL_REGEX[:job])).to be true
      end

      it 'Invalid' do
        expect(described_class.match?(input_str: 'https://angel.co/company/twitter/jobs1/576275-engineering-manager',
                                      regex: SocialsRegex::Regexes::ANGELLIST_URL_REGEX[:job])).to be false
      end
    end

    context 'with user validate' do
      it 'u shortcut Valid' do
        expect(described_class.match?(input_str: 'https://angel.co/u/karllorey',
                                      regex: SocialsRegex::Regexes::ANGELLIST_URL_REGEX[:user])).to be true
      end

      it 'p shortcut valid' do
        expect(described_class.match?(input_str: 'https://angel.co/p/naval',
                                      regex: SocialsRegex::Regexes::ANGELLIST_URL_REGEX[:user])).to be true
      end

      it 'InValid' do
        expect(described_class.match?(input_str: 'https://angel.co/user/naval',
                                      regex: SocialsRegex::Regexes::ANGELLIST_URL_REGEX[:user])).to be false
      end
    end
  end

  context SocialsRegex::Platforms::PLATFORM_CRUNCHBASE do
    context 'with company validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'http://crunchbase.com/organization/acme-corp',
                                      regex: SocialsRegex::Regexes::CRUNCHBASE_URL_REGEX[:company])).to be true
      end

      it 'Invalid' do
        expect(described_class.match?(input_str: 'http://crunchbase.com/organizationx/acme-corp',
                                      regex: SocialsRegex::Regexes::CRUNCHBASE_URL_REGEX[:company])).to be false
      end
    end

    context 'with person validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'http://crunchbase.com/person/karl-lorey',
                                      regex: SocialsRegex::Regexes::CRUNCHBASE_URL_REGEX[:person])).to be true
      end

      it 'Invalid' do
        expect(described_class.match?(input_str: 'http://crunchbase.com/user/karl-lorey',
                                      regex: SocialsRegex::Regexes::CRUNCHBASE_URL_REGEX[:person])).to be false
      end
    end
  end

  context SocialsRegex::Platforms::PLATFORM_EMAIL do
    context 'with email validate' do
      it 'Valid without mailto' do
        expect(described_class.match?(input_str: 'jeff@amazon.com',
                                      regex: SocialsRegex::Regexes::EMAIL_URL_REGEX[:email])).to be true
      end

      it 'Valid with mailto' do
        expect(described_class.match?(input_str: 'mailto:jeff@amazon.com',
                                      regex: SocialsRegex::Regexes::EMAIL_URL_REGEX[:email])).to be true
      end

      it 'Valid with special chars' do
        expect(described_class.match?(input_str: 'mailto:plususer+test@gmail.com',
                                      regex: SocialsRegex::Regexes::EMAIL_URL_REGEX[:email])).to be true
      end

      it 'InValid' do
        expect(described_class.match?(input_str: 'plususer+test@@gmail.com',
                                      regex: SocialsRegex::Regexes::EMAIL_URL_REGEX[:email])).to be false
      end
    end

    context 'with email_without_extract validate' do
      it 'Valid without mailto' do
        expect(described_class.match?(input_str: 'jeff@amazon.com',
                                      regex: SocialsRegex::Regexes::EMAIL_URL_REGEX[:email_without_extract])).to be true
      end

      it 'InValid' do
        expect(described_class.match?(input_str: 'plususer#test@gmail.com',
                                      regex: SocialsRegex::Regexes::EMAIL_URL_REGEX[:email_without_extract]))
          .to be false
      end
    end
  end

  context SocialsRegex::Platforms::PLATFORM_FACEBOOK do
    context 'with username validate' do
      it 'Valid with fb domain' do
        expect(described_class.match?(input_str: ' http://fb.com/peter_parker-miller',
                                      regex: SocialsRegex::Regexes::FACEBOOK_URL_REGEX[:username])).to be true
      end

      it 'valid with facebook domain with special char' do
        expect(described_class.match?(input_str: 'https://facebook.com/peter.parker',
                                      regex: SocialsRegex::Regexes::FACEBOOK_URL_REGEX[:username])).to be true
      end

      it 'valid with facebook domain' do
        expect(described_class.match?(input_str: 'https://facebook.com/peterparker',
                                      regex: SocialsRegex::Regexes::FACEBOOK_URL_REGEX[:username])).to be true
      end
    end

    context 'with profile_id validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'https://www.facebook.com/100004123456789',
                                      regex: SocialsRegex::Regexes::FACEBOOK_URL_REGEX[:profile_id])).to be true
      end

      it 'valid with id query params' do
        expect(described_class.match?(input_str: 'https://www.facebook.com/profile.php?id=100004123456789',
                                      regex: SocialsRegex::Regexes::FACEBOOK_URL_REGEX[:profile_id])).to be true
      end
    end
  end

  context SocialsRegex::Platforms::PLATFORM_GITHUB do
    context 'with repo validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'https://github.com/talaatmagdyx/socials_regex',
                                      regex: SocialsRegex::Regexes::GITHUB_URL_REGEX[:repo])).to be true
      end
    end

    context 'with user validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'https://github.com/talaatmagdyx',
                                      regex: SocialsRegex::Regexes::GITHUB_URL_REGEX[:user])).to be true
      end
    end
  end

  context SocialsRegex::Platforms::PLATFORM_HACKER_NEWS do
    context 'with item validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'https://news.ycombinator.com/item?id=23290375',
                                      regex: SocialsRegex::Regexes::HACKERNEWS_URL_REGEX[:item])).to be true
      end

      it 'Invalid' do
        expect(described_class.match?(input_str: 'https://news.ycombinator.com/items?id=23290375',
                                      regex: SocialsRegex::Regexes::HACKERNEWS_URL_REGEX[:item])).to be false
      end
    end

    context 'with user validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'https://news.ycombinator.com/user?id=CamelCaps',
                                      regex: SocialsRegex::Regexes::HACKERNEWS_URL_REGEX[:user])).to be true
      end

      it 'Invalid' do
        expect(described_class.match?(input_str: 'https://news.ycombinator.com/users?id=CamelCaps',
                                      regex: SocialsRegex::Regexes::HACKERNEWS_URL_REGEX[:user])).to be false
      end
    end
  end

  context SocialsRegex::Platforms::PLATFORM_INSTAGRAM do
    context 'with profile validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'https://instagram.com/__disco__dude',
                                      regex: SocialsRegex::Regexes::INSTAGRAM_URL_REGEX[:profile])).to be true
      end
    end
  end

  context SocialsRegex::Platforms::PLATFORM_LINKEDIN do
    context 'with company validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'https://fr.linkedin.com/school/université-grenoble-alpes/',
                                      regex: SocialsRegex::Regexes::LINKEDIN_URL_REGEX[:company])).to be true
      end
    end

    context 'with post validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'https://www.linkedin.com/feed/update/urn:li:activity:6665508550111912345/',
                                      regex: SocialsRegex::Regexes::LINKEDIN_URL_REGEX[:post])).to be true
      end
    end

    context 'with profile validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'https://www.linkedin.com/in/talaatmagdyx/',
                                      regex: SocialsRegex::Regexes::LINKEDIN_URL_REGEX[:profile])).to be true
      end
    end
  end

  context SocialsRegex::Platforms::PLATFORM_MEDIUM do
    context 'with post validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'https://medium.com/does-exist/some-post-123abc',
                                      regex: SocialsRegex::Regexes::MEDIUM_URL_REGEX[:post])).to be true
      end
    end

    context 'with post_of_subdomain_publication validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'https://onezero.medium.com/what-facebooks-remote-work-policy-means-for-the-future-of-tech-salaries-everywhere-edf859226b62?source=grid_home------',
                                      regex: SocialsRegex::Regexes::MEDIUM_URL_REGEX[:post_of_subdomain_publication]))
          .to be true
      end
    end

    context 'with user validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'https://medium.com/@karllorey',
                                      regex: SocialsRegex::Regexes::MEDIUM_URL_REGEX[:user])).to be true
      end
    end

    context 'with user_by_id validate' do
      it 'Valid' do
        expect(described_class.match?(input_str: 'https://medium.com/u/b3d3d3653c2c?source=post_page-----da92b81b85ef-',
                                      regex: SocialsRegex::Regexes::MEDIUM_URL_REGEX[:user_by_id])).to be true
      end
    end
  end

  context SocialsRegex::Platforms::PLATFORM_PHONE do
    context 'with number validate' do
      it 'Valid tel:+49 900 123456 like format' do
        expect(described_class.match?(input_str: 'tel:+49 900 123456',
                                      regex: SocialsRegex::Regexes::PHONE_URL_REGEX[:number])).to be true
      end

      it 'Valid tel:+49900123456 like format' do
        expect(described_class.match?(input_str: 'tel:+49900123456',
                                      regex: SocialsRegex::Regexes::PHONE_URL_REGEX[:number])).to be true
      end
    end
  end

  context SocialsRegex::Platforms::PLATFORM_REDDIT do
    context 'with user validate' do
      it 'Valid with user in path' do
        expect(described_class.match?(input_str: 'https://old.reddit.com/user/ar-guetita',
                                      regex: SocialsRegex::Regexes::REDDIT_URL_REGEX[:user])).to be true
      end

      it 'Valid with u in path' do
        expect(described_class.match?(input_str: 'https://reddit.com/u/ar-guetita',
                                      regex: SocialsRegex::Regexes::REDDIT_URL_REGEX[:user])).to be true
      end
    end
  end


end
