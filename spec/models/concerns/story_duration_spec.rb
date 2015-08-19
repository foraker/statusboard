require 'rails_helper'

class SomethingWithDuration
  include StoryDuration
end

describe SomethingWithDuration do
  describe '#duration_in_words' do
    let(:story) { SomethingWithDuration.new.duration_in_words(2.days.to_i + 2.hours.to_i) }
    it 'returns the duration of a story in words' do
      expect(story).to eq "2 days and 2 hours"
    end
  end
end
