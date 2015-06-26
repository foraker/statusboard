require "twitter-text"
class UrlParser
    include Twitter::Extractor
    include Twitter::Autolink
end
