class CreatePivotalProjects < ActiveRecord::Migration
  def change
    create_table :pivotal_projects do |t|
      t.integer :pivotal_id
      t.text :name
      t.text :point_scale
      t.datetime :updated_at
      t.datetime :created_at
    end
  end
end
