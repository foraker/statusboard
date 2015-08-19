require 'spec_helper'

module Presenters
  describe PullRequest do
    describe '#repository' do
      it 'titleizes the repo name' do
        pull_request = double(repository: 'some_repo-name')
        expect(described_class.new(pull_request).repository).to eq 'Some Repo Name'
      end
    end
  end
end
