module Presenters
  class PivotalProject < Base
    include StoryDuration

    def cycle_time
      duration_in_words(average_cycle_time)
    end
  end
end
