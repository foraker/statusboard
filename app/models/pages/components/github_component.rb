module Pages
  module Components
    class GithubComponent
      def pull_requests
        @pull_requests ||= PullRequest.active.ordered
      end

      def approved_pull_requests
        pull_requests.select(&:approved?)
      end

      def unapproved_pull_requests
        pull_requests.reject(&:approved?)
      end
    end
  end
end
