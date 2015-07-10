require "twitter-text"
class UrlParser
  include Twitter::Extractor
  include Twitter::Autolink

  def self.first_url(text)
    new.extract_urls(text)[0]
  end
end
