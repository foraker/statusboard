require 'spec_helper'

module Presenters
  describe PullRequest do
    describe '#repository' do
      it 'removes underscores and dashes from the repo name' do
        pull_request = double(repository: 'some_repo-name')
        expect(described_class.new(pull_request).repository).to eq 'some repo name'
      end
    end
  end
end
