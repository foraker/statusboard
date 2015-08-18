require 'rails_helper'

describe StoryDuration do
  describe 'duration_in_words' do
    started_at = ActiveSupport::TimeZone['UTC'].parse("12/08/2015 12:00:00")
    accepted_at = ActiveSupport::TimeZone['UTC'].parse("14/08/2015 14:00:00")
    story = FactoryGirl.create(:pivotal_story, started_at: started_at, accepted_at: accepted_at)

    it 'returns the duration of a story in words' do
      expect(story.duration_in_words(story.duration)).to eq "2 days and 2 hours"
    end
  end
end
