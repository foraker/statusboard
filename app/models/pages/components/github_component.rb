module Pages
  module Components
    class GithubComponent
      include PullRequests

      def pull_requests
        @pull_requests ||= PullRequest.active.ordered
      end
    end
  end
end
