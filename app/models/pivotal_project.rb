class PivotalProject < ActivePivot::Project
  validates :pivotal_id, :name, presence: true

  def self.with_id(pivotal_ids)
    where(pivotal_id: pivotal_ids)
  end

  def self.ordered_by_name
    order(:name)
  end

  def self.name_by_id(pivotal_id)
    find_by_pivotal_id(pivotal_id).name
  end

  def average_cycle_time
    PivotalStory.month_cycle_time(pivotal_id)
  end
end
