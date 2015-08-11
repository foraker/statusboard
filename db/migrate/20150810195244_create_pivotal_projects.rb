class CreatePivotalProjects < ActiveRecord::Migration
  def change
    create_table :pivotal_projects do |t|
      t.integer :pivotal_id
      t.text :name
      t.text :point_scale
    end
  end
end
