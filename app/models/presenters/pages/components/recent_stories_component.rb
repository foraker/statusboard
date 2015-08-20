module Presenters
  module Pages
    module Components
      class RecentStoriesComponent < Base
        def stories
          present_collection super
        end

        def started_duration
          duration_in_words((Time.zone.now - started_at.to_datetime).to_i)
        end
      end
    end
  end
end
