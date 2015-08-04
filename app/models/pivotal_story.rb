class PivotalStory < ActiveRecord::Base
  validates :project_id, :story_id, :started_at, :project_name, presence: true
end
