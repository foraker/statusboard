module Presenters
  class PullRequest < Base
    def repository
      super.gsub(/[_-]/, ' ')
    end
  end
end
