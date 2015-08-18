module Presenters
  module Pages
    module Components
      class OpenStoriesComponent < Base
        def projects
          present_collection super
        end
      end
    end
  end
end
