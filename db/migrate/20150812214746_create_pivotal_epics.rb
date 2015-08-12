class CreatePivotalEpics < ActiveRecord::Migration
  def change
    create_table :pivotal_epics do |t|
      t.integer :project_id
      t.integer :pivotal_id
      t.integer :label_id
      t.string :name
      t.string :url
      t.datetime :updated_at
      t.datetime :created_at
    end
    add_index :pivotal_epics, :project_id
  end
end
