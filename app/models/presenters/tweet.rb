module Presenters
  class Tweet < Base
    def text
      UrlParser.new.auto_link_urls(tweet)
    end
  end
end
