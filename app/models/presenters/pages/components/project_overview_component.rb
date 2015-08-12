module Presenters
  module Pages
    module Components
      class ProjectOverviewComponent < Base
        def projects
          present_collection super, presenter: Presenters::PivotalProject
        end
      end
    end
  end
end
