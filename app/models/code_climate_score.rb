class CodeClimateScore < ActiveRecord::Base
  belongs_to :project

  def self.latest
    order(:created_at).last
  end

  def self.for_project(project)
    where(project_id: project)
  end
end
