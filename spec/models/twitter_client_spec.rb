require 'models/twitter_client'

describe TwitterClient do

  module Twitter; module REST; class Client; end; end; end

  let(:config) do
    double(
      twitter_consumer_key:        'consumer key',
      twitter_consumer_secret:     'consumer secret',
      twitter_access_token:        'access token',
      twitter_access_token_secret: 'access token secret'
    )
  end

  let(:client)         { described_class.new(config) }
  let(:twitter_client) { double }
  let(:mentions)       { double }

  describe '#latest_mentions' do
    before do
      allow(Twitter::REST::Client).to receive(:new) { twitter_client }
    end

    it 'returns the latest mention' do
      allow(twitter_client).to receive(:mentions_timeline).with(count: 5).and_return(
        mentions
      )

      expect(client.latest_mentions(5)).to eq mentions
    end
  end
end
