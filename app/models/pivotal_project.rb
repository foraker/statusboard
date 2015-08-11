class PivotalProject < ActivePivot::Project
  validates :pivotal_id, :name, presence: true

  def self.project_name(project_id)
    PivotalProject.find_by_pivotal_id(project_id.to_i).name
  end
end
