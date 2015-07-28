module Presenters
  module Pages
    module Components
      class GithubComponent < Base
        def approved_pull_requests
          present_collection super
        end

        def unapproved_pull_requests
          present_collection super
        end
      end
    end
  end
end
