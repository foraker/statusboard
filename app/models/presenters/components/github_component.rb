module Presenters
  module Components
    class GithubComponent < StatusBoardComponent
      def pull_requests
        PullRequest.wrap(super)
      end

      private

      class PullRequest < SimpleDelegator
        def self.wrap(pull_requests)
          pull_requests.map { |pull_request| new(pull_request) }
        end

        def css_class
          approved? ? 'success' : 'danger'
        end
      end
    end
  end
end
