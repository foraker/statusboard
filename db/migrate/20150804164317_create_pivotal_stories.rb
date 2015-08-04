class CreatePivotalStories < ActiveRecord::Migration
  def change
    create_table :pivotal_stories do |t|
      t.string :project_id
      t.string :story_id
      t.datetime :started_at
      t.datetime :accepted_at
      t.text :story_name
      t.string :project_name
      t.timestamps null: false
    end
  end
end
