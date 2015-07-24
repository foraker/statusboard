module Presenters
  module Pages
    class PullRequestsPage < PagePresenter
      presents :github_component
    end
  end
end
