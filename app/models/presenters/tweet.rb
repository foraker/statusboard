module Presenters
  class Tweet < Base
    def text
      UrlParser.new.auto_link_urls(tweet)
    end

    def date
      published_at.to_date
    end
  end
end
