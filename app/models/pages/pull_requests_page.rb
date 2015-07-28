module Pages
  class PullRequestsPage < StatusBoardPage
    def github_component
      @github_component ||= Components::GithubComponent.new
    end
  end
end
