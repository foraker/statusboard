module Presenters
  class PullRequest < Base
    def repository
      super.titleize
    end
  end
end
