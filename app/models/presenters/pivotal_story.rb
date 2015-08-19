module Presenters
  class PivotalStory < Base
    include StoryDuration

    def story
      present super
    end

    def cycle_time
      duration_in_words(average_cycle_time)
    end

    def started_duration
      duration_in_words((Time.zone.now - started_at.to_datetime).to_i)
    end

    def icon
      case story.story_type
      when 'feature'
        'star'
      when 'bug'
        'bug'
      when 'chore'
        'cog'
      end
    end
  end
end
