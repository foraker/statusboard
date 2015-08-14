module Presenters
  class Project < Base
    delegate :cycle_time, to: :pivotal_project

    def pivotal_project
      present super
    end

    def approved_pull_requests_count
      approved_pull_requests.count
    end

    def unapproved_pull_requests_count
      unapproved_pull_requests.count
    end
  end
end
