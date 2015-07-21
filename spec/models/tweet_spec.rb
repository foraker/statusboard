require 'spec_helper'

describe Tweet do
  describe '.latest(count)' do
    it 'returns the latest tweets based on published_at' do
      three = FactoryGirl.create(:tweet, published_at: 5.days.ago)
      two = FactoryGirl.create(:tweet, published_at: 3.days.ago)
      one = FactoryGirl.create(:tweet, published_at: 1.day.ago)

      expect(described_class.latest(2)).to eq [one, two]
    end
  end
end
