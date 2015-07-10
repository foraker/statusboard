require 'rails_helper'

RSpec.describe Announcement, type: :model do
  describe '.unannounced' do
    it 'returns unannounced announcements' do
      included = FactoryGirl.create :announcement, announced_at: nil
      excluded = FactoryGirl.create :announcement, announced_at: Time.now

      expect(described_class.unannounced).to eq [included]
    end
  end

  describe '.oldest_first' do
    it 'returns the oldest announcement first' do
      one = FactoryGirl.create :announcement, created_at: 2.days.ago
      two = FactoryGirl.create :announcement

      expect(described_class.oldest_first).to eq [one, two]
    end
  end
end
