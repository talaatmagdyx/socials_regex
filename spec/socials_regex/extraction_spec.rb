# frozen_string_literal: true

RSpec.describe SocialsRegex::Extraction do
  describe '#initialize' do
    it 'uses that text' do
      text = 'https://twitter.com/karllorey/status/1259924082067374088'
      extraction = described_class.new(text: text)
      expect(extraction.text).to eq text
    end
  end

  describe '#extract_matches_per_platform' do
    context 'with one link' do
      text = 'https://twitter.com/karllorey/status/1259924082067374088'
      extraction = described_class.new(text: text)
      let(:matches) { extraction.extract_matches_per_platform }

      it '#validate platform' do
        expect(matches.keys).to eq [:twitter]
      end

      it '#validate nested named_captures for example status in twitter' do
        expect(matches[:twitter].key?(:status)).to be true
      end

      it '#validate nested named_captures for example user in twitter' do
        expect(matches[:twitter].key?(:user)).to be true
      end

      it '#validate matched text like input' do
        expect(matches[:twitter][:status][0][:matched]).to eq text
      end

      it '#validate size of matching' do
        expect(matches[:twitter].keys.length).to eq 2
      end
    end

    context 'with different link with same platform' do
      text = 'https://twitter.com/karllorey/status/1259924082067374088 \
                https://twitter.com/karllorey12/status/12599240820673740883'
      extraction = described_class.new(text: text)
      matches = extraction.extract_matches_per_platform

      it '#validate platform' do
        expect(matches.keys).to eq [:twitter]
      end

      it '#validate nested named_captures for example status in twitter' do
        expect(matches[:twitter].key?(:status)).to be true
      end

      it '#validate nested named_captures for example user in twitter' do
        expect(matches[:twitter].key?(:user)).to be true
      end

      it '#validate size of matching with same platform with different link' do
        expect(matches[:twitter].keys.length).to eq 2
      end

      it '#validate size of links with nested keys like #user in twitter with same platform with different link' do
        expect(matches[:twitter][:user].length).to eq 2
      end

      it '#validate size of links with nested keys like #status in twitter with same platform with different link' do
        expect(matches[:twitter][:status].length).to eq 2
      end
    end

    context 'with multiple link with different platform' do
      text = 'https://twitter.com/karllorey/status/1259924082067374088' \
             'https://twitter.com/karllorey12/status/12599240820673740883' \
             'http://crunchbase.com/organization/acme-corp jeff@amazon.com mailto:plususer+test@gmail.com' \
             'https://facebook.com/peter.parker https://www.facebook.com/profile.php?id=100004123456789' \
             'https://github.com/talaatmagdyx https://github.com/talaatmagdyx/socials_regex' \
             'https://news.ycombinator.com/item?id=23290375 https://instagram.com/__disco__dude' \
             'https://www.linkedin.com/in/talaatmagdyx/ https://medium.com/does-exist/some-post-123abc'
      extraction = described_class.new(text: text)
      matches = extraction.extract_matches_per_platform

      it '#validate platform with multiple link with different platform' do
        expect(matches.keys).to eq %i[crunchbase medium hackernews email instagram twitter
                                      linkedin github facebook]
      end

      it '#validate nested named_captures for example status in twitter with multiple link with different platform' do
        expect(matches[:twitter].key?(:status)).to be true
      end

      it '#validate nested named_captures for example user in twitter with multiple link with different platform' do
        expect(matches[:twitter].key?(:user)).to be true
      end

      it '#validate size of matching with multiple link with different platform' do
        expect(matches[:twitter].keys.length).to eq 2
      end

      it '#validate size of links with nested keys like #user in twitter with multiple link with different platform' do
        expect(matches[:twitter][:user].length).to eq 2
      end
    end
  end

  describe '#extract_matches_by_regex' do
    it 'extract data from string using regex' do
      text = 'https://twitter.com/karllorey/status/1259924082067374088'
      extraction = described_class.new(text: text)
      matches = extraction.extract_matches_by_regex(regex: SocialsRegex::Regexes::TWITTER_URL_REGEX[:status])
      expect(matches[0][:matched]).to eq text
    end
  end

  describe '#extract_matches_by_platform' do
    it 'extract data from string using platform' do
      text = 'https://twitter.com/karllorey/status/1259924082067374088'
      extraction = described_class.new(text: text)
      matches = extraction.extract_matches_by_platform(platform: SocialsRegex::Platforms::PLATFORM_TWITTER)
      expect(matches[SocialsRegex::Platforms::PLATFORM_TWITTER][:status][0][:matched]).to eq text
    end
  end
end
